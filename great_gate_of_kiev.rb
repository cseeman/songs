# The Great Gate of Kiev from Pictures at an Exhibition
# by Modest Mussorgsky
# Sonic Pi arrangement

use_bpm 76

define :gate_theme do |transpose_by = 0|
  use_synth :brass
  use_transpose transpose_by

  play_pattern_timed [:Eb4, :Eb4, :F4, :G4], [0.75, 0.25, 0.5, 1.5], amp: 1.2, release: 0.3
  play_pattern_timed [:Ab4, :G4, :F4, :Eb4], [0.5, 0.5, 0.5, 1.5], amp: 1.2, release: 0.3
  play_pattern_timed [:F4, :G4, :Ab4, :Bb4], [0.75, 0.25, 0.5, 1.5], amp: 1.2, release: 0.3
  play_pattern_timed [:C5, :Bb4, :Ab4, :G4], [0.5, 0.5, 0.5, 1.5], amp: 1.2, release: 0.3
end

define :harmony_line do |transpose_by = 0|
  use_synth :fm
  use_transpose transpose_by

  play_pattern_timed [:Eb3, :Eb3, :C3, :Eb3], [1, 1, 1, 1], amp: 0.6, release: 0.8
  play_pattern_timed [:Ab3, :Bb3, :Ab3, :G3], [1, 1, 1, 1], amp: 0.6, release: 0.8
  play_pattern_timed [:F3, :G3, :Ab3, :Bb3], [1, 1, 1, 1], amp: 0.6, release: 0.8
  play_pattern_timed [:C4, :Bb3, :Ab3, :G3], [1, 1, 1, 1], amp: 0.6, release: 0.8
end

define :bass_line do |transpose_by = 0|
  use_synth :fm
  use_synth_defaults divisor: 1, depth: 2
  use_transpose transpose_by

  play_pattern_timed [:Eb2, :Eb2, :Ab2, :Eb2], [2, 2, 2, 2], amp: 0.8, release: 1.5
  play_pattern_timed [:F2, :Bb2, :Ab2, :Eb2], [2, 2, 2, 2], amp: 0.8, release: 1.5
end

define :bell_chords do
  use_synth :pretty_bell

  play_chord [:Eb4, :G4, :Bb4], amp: 0.5, release: 2
  sleep 4
  play_chord [:Ab4, :C5, :Eb5], amp: 0.5, release: 2
  sleep 4
  play_chord [:F4, :Ab4, :C5], amp: 0.5, release: 2
  sleep 4
  play_chord [:Eb4, :G4, :Bb4, :Eb5], amp: 0.6, release: 3
  sleep 4
end

define :timpani_roll do
  use_synth :noise
  use_synth_defaults attack: 0.01, sustain: 0.1, release: 0.1, cutoff: 60

  16.times do
    play :c2, amp: rrand(0.3, 0.5), pan: rrand(-0.2, 0.2)
    sleep 0.125
  end
end

puts "Playing: The Great Gate of Kiev"
puts "Press Stop to end"
puts "Enable Scope for visualization"

cue :introduction

in_thread do
  sleep 16
  loop do
    cue :timpani
    timpani_roll
    sleep 16
  end
end

in_thread do
  cue :bells
  2.times do
    bell_chords
  end
end

in_thread do
  cue :bass
  bass_line
  bass_line
end

in_thread do
  sleep 2
  cue :harmony
  harmony_line
  harmony_line
end

cue :main_theme
gate_theme
sleep 0.5
gate_theme

sleep 2

puts "Building to climax..."
cue :build

in_thread do
  bass_line 12
end

in_thread do
  harmony_line 12
end

gate_theme 12

sleep 1

cue :finale
use_synth :brass
play_chord [:Eb5, :G5, :Bb5, :Eb6], amp: 1.5, release: 4, attack: 0.1
sleep 4

puts "Finale!"

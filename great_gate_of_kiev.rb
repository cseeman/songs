# The Great Gate of Kiev from Pictures at an Exhibition
# by Modest Mussorgsky
# Sonic Pi arrangement
#
# Key: Eb major (opening) / D minor sections
#
# Valid Sonic Pi synths used:
# - :prophet (brass-like lead)
# - :dsaw (deep bass)
# - :fm (harmony)
# - :pretty_bell (chimes)
# - :noise (timpani percussion)

use_bpm 76

# Main theme - majestic sustained chords (opening bars 1-5)
define :gate_theme do |transpose_by = 0|
  use_synth :prophet
  use_synth_defaults cutoff: 90, res: 0.5, attack: 0.1
  use_transpose transpose_by

  # Measure 1: Whole note (4 beats) - Eb major
  play_chord [:Eb4, :G4, :Bb4, :Eb5], amp: 1.2, release: 3.8, sustain: 3.5
  sleep 4

  # Measure 2: Whole note (4 beats) - Bb major (different chord)
  play_chord [:Bb3, :D4, :F4, :Bb4], amp: 1.2, release: 3.8, sustain: 3.5
  sleep 4

  # Measure 3: Half note (2 beats) + two quarter notes slurred (1+1 beats)
  play_chord [:C4, :F4, :A4], amp: 1.2, release: 1.8, sustain: 1.5
  sleep 2
  play :F4, amp: 1.2, release: 0.9, sustain: 0.5
  sleep 1
  play :A4, amp: 1.2, release: 0.9, sustain: 0.5
  sleep 1

  # Measure 4: Two half notes (2+2 beats)
  play_chord [:C4, :E4, :G4], amp: 1.3, release: 1.8, sustain: 1.5
  sleep 2
  play :C4, amp: 1.3, release: 1.8, sustain: 1.5
  sleep 2

  # Measure 5: Four quarter notes (1+1+1+1 beats)
  play_chord [:F4, :A4], amp: 1.3, release: 0.9, sustain: 0.5
  sleep 1
  play :C5, amp: 1.3, release: 0.9, sustain: 0.5
  sleep 1
  play :G4, amp: 1.3, release: 0.9, sustain: 0.5
  sleep 1
  play :F4, amp: 1.4, release: 0.9, sustain: 0.5
  sleep 1
end

# Melodic passage (appears later in the piece with running notes)
define :melodic_run do |transpose_by = 0|
  use_synth :prophet
  use_synth_defaults cutoff: 95, res: 0.4, attack: 0.02
  use_transpose transpose_by

  # Flowing eighth note patterns based on bar 15+
  notes = [:Eb4, :F4, :G4, :Eb4, :Ab4, :G4, :F4, :Eb4]
  times = [0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5]
  play_pattern_timed notes, times, amp: 1.0, release: 0.4
end

# Supporting harmony using FM synthesis (inner voices)
define :harmony_line do |transpose_by = 0|
  use_synth :fm
  use_synth_defaults divisor: 0.5, depth: 1.5, attack: 0.1, sustain: 1.5
  use_transpose transpose_by

  # Sustained inner harmony notes (2 beats each)
  play_pattern_timed [:G3, :G3, :Ab3, :G3], [2, 2, 2, 2], amp: 0.7, release: 1.8
  play_pattern_timed [:Bb3, :Bb3, :C4, :Bb3], [2, 2, 2, 2], amp: 0.7, release: 1.8
end

# Deep bass foundation using detuned saw wave
define :bass_line do |transpose_by = 0|
  use_synth :dsaw
  use_synth_defaults cutoff: 80, detune: 0.2, attack: 0.05, sustain: 3.5
  use_transpose transpose_by

  # Sustained bass notes supporting the harmony (4 beats each)
  play :Eb2, amp: 0.9, release: 3.8
  sleep 4
  play :Eb2, amp: 0.9, release: 3.8
  sleep 4
  play :F2, amp: 0.9, release: 3.8
  sleep 4
  play :Eb2, amp: 0.9, release: 3.8
  sleep 4
end

# Cathedral bells for atmospheric effect
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

# Timpani drum roll using filtered noise
define :timpani_roll do
  use_synth :noise
  use_synth_defaults attack: 0.01, sustain: 0.1, release: 0.1, cutoff: 60

  16.times do
    play :c2, amp: rrand(0.3, 0.5), pan: rrand(-0.2, 0.2)
    sleep 0.125
  end
end

# Main performance - layered threads for orchestral effect
puts "Playing: The Great Gate of Kiev"
puts "Press Stop to end"
puts "Enable Scope for visualization"

cue :introduction

# Section 1: Opening majestic chords (bars 1-7)
in_thread do
  cue :bass
  bass_line
end

in_thread do
  cue :bells
  bell_chords
end

cue :main_theme
gate_theme

sleep 2

# Section 2: Building with melodic material
puts "Adding melodic passages..."
cue :melodic_section

in_thread do
  bass_line
end

in_thread do
  sleep 4
  melodic_run
end

gate_theme

sleep 2

# Section 3: Climax with transposition
puts "Building to climax..."
cue :build

in_thread do
  sleep 16
  loop do
    cue :timpani
    timpani_roll
    sleep 16
  end
end

in_thread do
  bass_line 12
end

in_thread do
  sleep 2
  melodic_run 12
end

gate_theme 12

sleep 2

# Final triumphant chord
cue :finale
use_synth :prophet
use_synth_defaults cutoff: 100, res: 0.6
play_chord [:Eb5, :G5, :Bb5, :Eb6], amp: 1.8, release: 6, attack: 0.1
sleep 6

puts "Finale!"

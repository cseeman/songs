# The Great Gate of Kiev from Pictures at an Exhibition
# by Modest Mussorgsky
# Sonic Pi arrangement
#
# Key: F major / C major progression
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

  # Measure 1: Whole note (4 beats) - F major triad
  play_chord [:A3, :C4, :F4], amp: 1.2, release: 3.8, sustain: 3.5
  sleep 4

  # Measure 2: Whole note (4 beats) - C major triad
  play_chord [:C4, :E4, :G4], amp: 1.2, release: 3.8, sustain: 3.5
  sleep 4

  # Measure 3: Half note (2 beats) + two quarter notes slurred (1+1 beats)
  play_chord [:C3, :F3, :A5], amp: 1.2, release: 1.8, sustain: 1.5
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

# Supporting harmony using FM synthesis (inner voices)
define :harmony_line do |transpose_by = 0|
  use_synth :fm
  use_synth_defaults divisor: 0.5, depth: 1.5, attack: 0.1, sustain: 3.5
  use_transpose transpose_by

  # Measure 1: F major harmony (4 beats)
  play :C4, amp: 0.7, release: 3.8
  sleep 4

  # Measure 2: C major harmony (4 beats)
  play :E4, amp: 0.7, release: 3.8
  sleep 4

  # Measure 3: F major harmony (4 beats total)
  play :F3, amp: 0.7, release: 3.8
  sleep 4

  # Measure 4: C major harmony (4 beats)
  play :G3, amp: 0.7, release: 3.8
  sleep 4
end

# Deep bass foundation using detuned saw wave
define :bass_line do |transpose_by = 0|
  use_synth :dsaw
  use_synth_defaults cutoff: 80, detune: 0.2, attack: 0.05, sustain: 3.5
  use_transpose transpose_by

  # Sustained bass notes supporting the harmony (4 beats each)
  # Measure 1: F major
  play :F2, amp: 0.9, release: 3.8
  sleep 4
  # Measure 2: C major
  play :C2, amp: 0.9, release: 3.8
  sleep 4
  # Measure 3: F major
  play :F2, amp: 0.9, release: 3.8
  sleep 4
  # Measure 4: C major
  play :C2, amp: 0.9, release: 3.8
  sleep 4
end

# Cathedral bells for atmospheric effect
define :bell_chords do
  use_synth :pretty_bell

  play_chord [:F4, :A4, :C5], amp: 0.5, release: 2
  sleep 4
  play_chord [:C4, :E4, :G4], amp: 0.5, release: 2
  sleep 4
  play_chord [:F4, :A4, :C5], amp: 0.5, release: 2
  sleep 4
  play_chord [:C4, :E4, :G4, :C5], amp: 0.6, release: 3
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

# Section 2: Building intensity
puts "Repeating theme..."
cue :theme_repeat

in_thread do
  bass_line
end

in_thread do
  harmony_line
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
  harmony_line 12
end

gate_theme 12

sleep 2

# Final triumphant chord
cue :finale
use_synth :prophet
use_synth_defaults cutoff: 100, res: 0.6
play_chord [:F5, :A5, :C6, :F6], amp: 1.8, release: 6, attack: 0.1
sleep 6

puts "Finale!"

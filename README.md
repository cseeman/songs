# Sonic Pi Musical Arrangements

Ruby-based musical compositions using [Sonic Pi](https://sonic-pi.net/).

## Installation

1. Download and install Sonic Pi from https://sonic-pi.net/
2. Available for macOS, Windows, Linux, and Raspberry Pi

## Running the Compositions

### Basic Usage

1. Open Sonic Pi
2. Load the `.rb` file via File > Open or copy code into a buffer
3. Press Run (or Cmd/Ctrl+R)
4. Press Stop to end playback

### Current Compositions

**The Great Gate of Kiev** (`great_gate_of_kiev.rb`)
- Grand finale from Mussorgsky's Pictures at an Exhibition
- BPM: 76
- Duration: Loops until stopped
- Layered orchestration with brass, bells, bass, and timpani

## Adding Visuals

### Built-in Scope

Sonic Pi includes a built-in oscilloscope visualizer:

1. Click "Scope" button in Sonic Pi interface
2. Select visualization type:
   - Waveform (default)
   - Frequency spectrum
   - Stereo view

### Custom Visual Effects

Add to your composition:

```ruby
# Control visual feedback with cue points
cue :section_change

# Sync external visualizers via OSC
use_osc "localhost", 4560
osc "/visual/intensity", 0.8
```

### External Visualization Tools

Sonic Pi can send OSC messages to:
- Processing sketches
- OpenFrameworks applications
- TouchDesigner
- Resolume Arena
- Custom JavaScript/WebGL visualizers

Example OSC integration:

```ruby
live_loop :visuals do
  use_osc "localhost", 4560

  # Send amplitude data
  osc "/amplitude", rrand(0.5, 1.0)

  # Send note data for color mapping
  osc "/note", :c4

  sleep 0.25
end
```

### Simple Visual Additions

Add to existing compositions:

```ruby
# Visual markers in console
puts "SECTION: Main Theme"

# Cue points for external sync
cue :theme_start
gate_theme
cue :theme_end

# Modulate effects for visual feedback
with_fx :reverb, room: 0.8 do
  # Your music here
end
```

## Tips

- Adjust `use_bpm` to change tempo
- Modify `amp:` parameters to balance volume
- Use `release:` and `attack:` to shape note envelope
- Add `sleep` for timing control
- Layer `in_thread` blocks for polyphony

## Resources

- [Sonic Pi Tutorial](https://sonic-pi.net/tutorial.html)
- [Sonic Pi Documentation](https://sonic-pi.net/docs.html)
- [OSC Communication](https://github.com/sonic-pi-net/sonic-pi/blob/dev/etc/doc/tutorial/12-OSC.md)

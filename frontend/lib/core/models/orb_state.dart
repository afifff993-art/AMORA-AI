/// Visual states of the AMORA AI core.
enum OrbState {
  idle('Idle', 'Slowly rotating holographic core.'),
  listening('Listening', 'Reactive waveform ring around the core.'),
  thinking('Thinking', 'Fast circular processing indicators.'),
  speaking('Speaking', 'Flowing waveform ring around the core.'),
  error('Error', 'Warning pulse in red.');

  const OrbState(this.label, this.description);

  final String label;
  final String description;
}

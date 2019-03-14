require 'journey'

describe Journey do

  let(:card_double) {double(:card)}
  let(:entry_station_double) {double(:station)}
  let(:exit_station_double) {double(:station)}
  let(:subject) {Journey.new(card_double)}

  it 'injects a card' do
    expect(subject.card).to eq card_double
  end

  it 'stores an entry station' do
    subject.start(entry_station_double)
    expect(subject.entry_station).to eq entry_station_double
  end

  it 'can tell if there is a live journey' do
    expect(subject).not_to be_in_journey
  end

  it 'stores an exit station' do
    allow(card_double).to receive(:journeys)
    allow(card_double).to receive(:deduct)
    allow(card_double).to receive(:update)
    subject.start(entry_station_double)
    subject.finish(exit_station_double)
  end


  it 'calculates a normal fare if journey is complete' do
    allow(subject).to receive(:complete?).and_return(true)
    expect(subject.calculate_fare).to eq 2
  end

  it 'calculates a penalty fare if journey is incomplete' do
    expect(subject.calculate_fare).to eq 6
  end

end

feature 'player takes incoming' do
  scenario 'until lost' do
    player = Player.new
    player.place(Destroyer, 'C5', :north) # Creates a new destroyer, stored in Board.ships
    player.place(Submarine, 'E7', :north)
    player.place(Destroyer, 'A1', :east)
    player.place(Submarine, 'F9', :west)
    expect(player.receive_hit('A1')).to eq :hit
    expect(player.receive_hit('B2')).to eq :miss
    expect(player.receive_hit('E6')).to eq :hit
    expect(player.receive_hit('C4')).to eq :hit
    expect(player.receive_hit('E9')).to eq :hit
    expect(player.receive_hit('C7')).to eq :miss
    expect(player.receive_hit('G6')).to eq :miss
    expect(player.receive_hit('H7')).to eq :miss
    expect(player.hits).to eq %w(A1 E6 C4 E9)
    expect(player.misses).to eq %w(B2 C7 G6 H7)
    expect(player).not_to be_lost
    expect(player.receive_hit('B1')).to eq :hit
    expect(player.receive_hit('C1')).to eq :hit
    expect(player.receive_hit('E7')).to eq :hit
    expect(player.receive_hit('C5')).to eq :hit
    expect(player.receive_hit('C3')).to eq :hit
    expect(player.receive_hit('F9')).to eq :hit
    expect(player.hits).to eq %w(A1 E6 C4 E9 B1 C1 E7 C5 C3 F9)
    expect(player).to be_lost
  end
end

require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Toothbrush" do
  before(:each) { visit '/dummy' }

  it 'talks to the dummy app' do
    expect(page).to have_content "Hey, ho, let's go!"
  end

  describe 'ensures table content' do
    it 'correct table' do
      expect(page).to include_table '#football-clubs-from-rio-de-janeiro-and-their-honors',
        [   'Club',    'World', 'Libertadores', 'Brasileiro', 'Copa do Brasil', 'Carioca'],
        [%w( Flamengo     1            1              6              2              32   ),
         %w( Vasco        0            1              4              1              22   ),
         %w( Fluminense   0            0              3              1              30   ),
         %w( Botafogo     0            0              1              0              19   )]
    end

    it 'vasco is not a world club champion' do
      expect {
        expect(page).to include_table '#football-clubs-from-rio-de-janeiro-and-their-honors',
          [   'Club',    'World', 'Libertadores', 'Brasileiro', 'Copa do Brasil', 'Carioca'],
          [%w( Flamengo     1            1              6              2              32   ),
           %w( Vasco        1            1              4              1              22   ),
           %w( Fluminense   0            0              3              1              30   ),
           %w( Botafogo     0            0              1              0              19   )]
       }.to raise_error(RSpec::Expectations::ExpectationNotMetError,
"""expected to include table
+------------+-------+--------------+------------+----------------+---------+
|    Club    | World | Libertadores | Brasileiro | Copa do Brasil | Carioca |
+------------+-------+--------------+------------+----------------+---------+
| Flamengo   | 1     | 1            | 6          | 2              | 32      |
| Vasco      | 1     | 1            | 4          | 1              | 22      |
| Fluminense | 0     | 0            | 3          | 1              | 30      |
| Botafogo   | 0     | 0            | 1          | 0              | 19      |
+------------+-------+--------------+------------+----------------+---------+
but found
+------------+-------+--------------+------------+----------------+---------+
|    Club    | World | Libertadores | Brasileiro | Copa do Brasil | Carioca |
+------------+-------+--------------+------------+----------------+---------+
| Flamengo   | 1     | 1            | 6          | 2              | 32      |
| Vasco      | 0     | 1            | 4          | 1              | 22      |
| Fluminense | 0     | 0            | 3          | 1              | 30      |
| Botafogo   | 0     | 0            | 1          | 0              | 19      |
+------------+-------+--------------+------------+----------------+---------+
""")
    end

    describe 'supports tables without <thead> and <tbody>' do
      it 'passing' do
        expect(page).to include_table '#without-thead-tbody',
          %w( 1 2),
          [%w(3 4),
           %w(5 6)]
     end

     it 'failing' do
        expect {
          expect(page).to include_table '#without-thead-tbody',
            %w( 1 2),
            [%w(3 4),
             %w(5 7)]
         }.to raise_error(RSpec::Expectations::ExpectationNotMetError,
"""expected to include table
+---+---+
| 1 | 2 |
+---+---+
| 3 | 4 |
| 5 | 7 |
+---+---+
but found
+---+---+
| 1 | 2 |
+---+---+
| 3 | 4 |
| 5 | 6 |
+---+---+
""")
     end
    end

    describe 'supports tables without header' do
      it 'passing' do
        expect(page).to include_table '#without-th',
          [%w(1 2),
           %w(3 4),
           %w(5 6)]
      end

      it 'failing' do
        expect {
          expect(page).to include_table '#without-th',
            [%w(1 2),
             %w(3 4),
             %w(6 6)]
        }.to raise_error(RSpec::Expectations::ExpectationNotMetError,
"""expected to include table
+---+---+
| 1 | 2 |
| 3 | 4 |
| 6 | 6 |
+---+---+
but found
+---+---+
| 1 | 2 |
| 3 | 4 |
| 5 | 6 |
+---+---+
""")
      end
    end

    describe 'supports tables with different <th> and <td> number' do
      it 'passing' do
        expect(page).to include_table '#different-th-td-number',
          ['Name', 'City'],
          [
            ['Americano', 'Campos', 'Destroy'],
            ['Goytacaz', 'Campos', "You can't destroy this"]
          ]
      end

      it 'failing' do
        expect {
          expect(page).to include_table '#different-th-td-number',
            ['Name', 'Cidade'],
            [
              ['Americano', 'Campos', 'Destroy'],
              ['Goytacaz', 'Campos', "You can't destroy this"]
            ]
        }.to raise_error(RSpec::Expectations::ExpectationNotMetError,
"""expected to include table
+-----------+--------+------------------------+
|   Name    | Cidade |                        |
+-----------+--------+------------------------+
| Americano | Campos | Destroy                |
| Goytacaz  | Campos | You can't destroy this |
+-----------+--------+------------------------+
but found
+-----------+--------+------------------------+
|   Name    |  City  |                        |
+-----------+--------+------------------------+
| Americano | Campos | Destroy                |
| Goytacaz  | Campos | You can't destroy this |
+-----------+--------+------------------------+
""")
      end
    end

    it 'supports partial table' do
      expect(page).to include_table '#football-clubs-from-rio-de-janeiro-and-their-honors',
          %w(    Club     World ),
          [%w( Flamengo     1   ),
           %w( Vasco        0   ),
           %w( Fluminense   0   ),
           %w( Botafogo     0   )]
    end

    it 'does not care about column ordering' do
      expect(page).to include_table '#football-clubs-from-rio-de-janeiro-and-their-honors',
          %w(  World    Club    ),
          [%w(   1    Flamengo  ),
           %w(   0     Vasco    ),
           %w(   0   Fluminense ),
           %w(   0    Botafogo  )]
    end

    describe 'supports <tfoot>' do
      it 'passing' do
        expect {
          expect(page).to include_table '#with-tfoot',
            [%w( 1 2 3 ),
             %w( 4 5 6 )],
             %w( 7 8 9 )
        }.to_not raise_error
      end

      it 'failing' do
        expect {
          expect(page).to include_table '#with-tfoot',
            [%w( 1 2 3 ),
             %w( 4 5 6 )],
             %w( 7 8 0 )
        }.to raise_error(RSpec::Expectations::ExpectationNotMetError,
  """expected to include table
+---+---+---+
| 1 | 2 | 3 |
| 4 | 5 | 6 |
+---+---+---+
| 7 | 8 | 0 |
+---+---+---+
but found
+---+---+---+
| 1 | 2 | 3 |
| 4 | 5 | 6 |
+---+---+---+
| 7 | 8 | 9 |
+---+---+---+
""")
      end

      it 'supports omitted columns' do
        expect {
          expect(page).to include_table '#with-tfoot-thead',
             %w( First   Third ),
            [%w(   1       3   ),
             %w(   4       6   )],
             %w(   7       9 )
        }.to_not raise_error
      end
    end
  end

  it 'supports table having nothing inside' do
    expect {
      expect(page).to include_table '#nothing-inside',
         ['a'],
        [['b'],
         ['c']]
     }.to raise_error(RSpec::Expectations::ExpectationNotMetError,
"""expected to include table
+---+
| a |
+---+
| b |
| c |
+---+
but found
++
++
""")
  end
end

require_relative 'test_helper'

describe NMax2 do
  it 'should get 2 max numbers from readed file' do
    assert_equal `cat #{Bundler.root}/test/fixtures/sample.txt | #{Bundler.root}/bin/nmax2 2}`,
      "87480913\n3801701\n"
  end

  it 'should return =no negative= if count is negative' do
    assert_equal `cat #{Bundler.root}/test/fixtures/sample.txt | #{Bundler.root}/bin/nmax2 -2}`,
      "== Count should not be a negative number ==\n"
  end

  it 'should return =not number= if count is negative' do
    assert_equal `cat #{Bundler.root}/test/fixtures/sample.txt | #{Bundler.root}/bin/nmax2 a}`,
      "== Empty output. Count should be a number and greater than 0 ==\n"
  end

  it 'should return =no numbers= if file have only text' do
    assert_equal `cat #{Bundler.root}/test/fixtures/sample_only_text.txt | #{Bundler.root}/bin/nmax2 2}`,
      "== There are no numbers in file ==\n"
  end

  def memstats
    `ps -o rss= #{Process.pid}`.strip.to_i
  end

  it 'should not load file to process memory' do
    file = Tempfile.new('tmp')
    file.write(('0'..'z').to_a.*(50_000).sample(1_000_000).join)
    file.rewind

    starting_memory = memstats

    NMax2.get(stdin: file, count: 5)

    assert memstats < starting_memory + 6000, 'Calculation has consumed more than 6MB'
  end
end

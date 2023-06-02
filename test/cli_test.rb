require_relative 'test_helper'

class CLITest < Minitest::Test

  def test_it_needs_an_explicit_interactive_or_noninteractive_option
    opts = {:non_interactive => nil, :interactive => nil}
    with_highline do
      begin
        I18n::Extractor::CLI.new('', opts).start
      rescue I18n::Extractor::CLI::CliError
        assert @output.string.match(/--help/), "passing interactive or not"
      end
    end
  end

  def test_with_a_interactive_option_it_needs_a_path
    opts = {:non_interactive => nil, :path => nil}
    with_highline do
      begin
        I18n::Extractor::CLI.new(nil, opts).start
      rescue I18n::Extractor::CLI::CliError
        assert @output.string.match(/--help/), "passing interactive or not needs path"
      end
    end
  end
end

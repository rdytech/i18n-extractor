require 'haml'
require 'haml/parser'
module Haml
  module I18n
    class Extractor
      class TextFinder

        include Helpers::StringHelpers

        # if any of the private handler methods return nil the extractor just outputs orig_line and keeps on going.
        # if there's an empty string that should do the trick to ( ExceptionFinder can return no match that way )
        def initialize(orig_line,line_metadata)
          @orig_line = orig_line
          @metadata = line_metadata
        end

        def process_by_regex
          # [ line_type, text_found ]
          #output_debug if Haml::I18n::Extractor.debug?
          result = @metadata && send("#{@metadata[:type]}", @metadata)
          result = FinderResult.new(nil,nil) if result.nil?
          result
        end

        class FinderResult
          attr_accessor :type, :match, :options

          def initialize(type, match, options = {})
            @type = type
            @match = match
            @options = options
          end
        end

        private

        def output_debug
          puts @metadata && @metadata[:type]
          puts @metadata.inspect
          puts @orig_line
        end

        def plain(line)
          txt = line[:value][:text]
          return nil if html_comment?(txt)
          FinderResult.new(:plain, txt)
        end

        def tag(line)
          txt = line[:value][:value]
          if txt
            has_script_in_tag = line[:value][:parse] # %element= foo
            if has_script_in_tag && !ExceptionFinder.could_match?(txt)
              FinderResult.new(:tag, "")
            else
              FinderResult.new(:tag, ExceptionFinder.new(txt).find, place: :content)
            end
          else
            FinderResult.new(:tag, "")
          end
        end

        def script(line)
          txt = line[:value][:text]
          if ExceptionFinder.could_match?(txt)
            FinderResult.new(:script, ExceptionFinder.new(txt).find)
          else
            FinderResult.new(:script, "")
          end
        end

        # returns nil, so extractor just keeps the orig_line and keeps on going.
        #
        # move to method missing and LINE_TYPES_IGNORE?
        # LINE_TYPES_IGNORE = [:silent_script, :haml_comment, :comment, :doctype, :root]
        def filter(line); end
        def silent_script(line); end
        def haml_comment(line); end
        def comment(line); end
        def doctype(line); end
        def root(line); end

      end
    end
  end
end

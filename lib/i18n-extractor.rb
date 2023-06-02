if defined?(Encoding)
  Encoding.default_internal = Encoding::UTF_8 if Encoding.respond_to?(:default_internal)
  Encoding.default_external = Encoding::UTF_8 if Encoding.respond_to?(:default_external)
end

require "trollop"

require "i18n-extractor/version"
require "i18n-extractor/helpers"

require "i18n-extractor/extraction/finder/text_finder"
require "i18n-extractor/extraction/finder/exception_finder"
require "i18n-extractor/extraction/replacer/text_replacer"
require "i18n-extractor/extraction/replacer/replacer_result"
require "i18n-extractor/extraction/replacer/interpolation_helper"

require "i18n-extractor/extraction/haml_parser"
require "i18n-extractor/extraction/haml_reader"
require "i18n-extractor/extraction/tagging_writer"
require "i18n-extractor/extraction/haml_writer"
require "i18n-extractor/extraction/yaml_writer"
require "i18n-extractor/extraction/extractor"


require "i18n-extractor/flow/prompter"
require "i18n-extractor/flow/user_action"
require "i18n-extractor/flow/workflow"
require "i18n-extractor/flow/cli"

require 'digest/sha1'
require 'dry/cli'
require 'yaml'

module Texts
  TEXTS_FILE = 'locales.ru.yml'.freeze

  class << self
    def get(category, key)
      load_texts[category.to_s][key.to_s]
    end

    private

    def load_texts
      @texts ||= YAML.load_file(TEXTS_FILE)
    end
  end
end

module CLI
  VERSION = '1.0.0'.freeze

  module Commands
    extend Dry::CLI::Registry

    class Version < Dry::CLI::Command
      desc Texts.get(:desc, :version)

      def call(*)
        puts VERSION
      end
    end

    class Generate < Dry::CLI::Command
      desc Texts.get(:desc, :generate)

      argument :string, type: :string, required: true, desc: Texts.get(:desc, :string)

      def call(string:)
        digest = Digest::SHA1.hexdigest(string)
        puts Texts.get(:info, :generate) % { hash: digest }
      end
    end

    class Compare < Dry::CLI::Command
      desc Texts.get(:desc, :compare)

      argument :string, type: :string, required: true, desc: Texts.get(:desc, :string)
      argument :hash, type: :string, required: true, desc: Texts.get(:desc, :hash)

      def call(string:, hash:)
        digest = Digest::SHA1.hexdigest(string)
        if digest == hash
          puts Texts.get(:info, :compare_success)
        else
          puts Texts.get(:info, :compare_failure)
        end
      end
    end

    class PictureConverter < Dry::CLI::Command
      ACCEPTED_FORMATS = %w[.jpg .jpeg .png].freeze

      desc Texts.get(:desc, :calc_picture)

      argument :picture, type: :string, required: true, desc: Texts.get(:desc, :picture)

      def call(picture:)
        pre_call_hook(picture)
        digest = Digest::SHA1.file(picture).hexdigest
        puts Texts.get(:info, :convert) % { hash: digest }
      end

      private

      def pre_call_hook(file)
        raise StandardError, Texts.get(:errors, :no_file) unless File.exist?(file)
        raise StandardError, Texts.get(:errors, :file_extension) unless ACCEPTED_FORMATS.include?(File.extname(file))
      end
    end

    register 'version', Version, aliases: %w[v -v --version]
    register 'generate', Generate, aliases: %w[g -g --generate]
    register 'compare', Compare, aliases: %w[--compare]
    register 'convert', PictureConverter, aliases: %w[--convert]
  end
end

Dry::CLI.new(CLI::Commands).call if $PROGRAM_NAME == __FILE__

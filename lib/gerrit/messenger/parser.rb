require 'json'

module Gerrit
  module Messenger
    module Parser

      module_function
      def parse(string)
        json = JSON.parse(string)
        case(json["type"])
        when 'comment-added'
          create_comment_added_message(json)
        when 'patchset-created'
          create_patchset_created_message(json)
        end
      end

      def create_comment_added_message(json)
        parsed = Gerrit::Messenger::Models::CommentAdded.new(json)
        "[COMMENT][#{parsed.score}] #{parsed.owner_name} -> #{parsed.author_name} \"#{parsed.subject}\" #{parsed.url}"
      end

      def create_patchset_created_message(json)
        parsed = Gerrit::Messenger::Models::PatchsetCreated.new(json)
        "[NEW PATCHSET] #{parsed.owner_name} \"#{parsed.subject}\" #{parsed.url}"
      end

    end
  end

end
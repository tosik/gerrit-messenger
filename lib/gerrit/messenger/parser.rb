require 'json'

module Gerrit
  module Messenger
    module Parser

      module_function
      def parse(string)
        json = JSON.parse(string)
        if (json["type"] == 'comment-added')
          create_comment_added_message(json)
        end
      end

      def create_comment_added_message(json)
        parsed = Gerrit::Messenger::Models::CommentAdded.new(json)
        "[COMMENT][#{parsed.score}] #{parsed.owner_name} -> #{parsed.author_name} \"#{parsed.subject}\" #{parsed.url}"
      end

    end
  end

end
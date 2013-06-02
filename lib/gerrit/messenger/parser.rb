require 'json'

module Gerrit
  module Messenger
    module Parser

      class CommentAddedJson
        def initialize(json)
          @json = json
        end

        def score
          approvals = @json["approvals"].reduce({}) {|hash, approval|
            hash.merge(case approval['type']
            when 'VRIF'
              { verified: approval['value']}
            when 'CRVW'
              { codereview: approval['value']}
            end)
          }
          if approvals[:verified] == '1' and approvals[:codereview] == '2'
            'LGTM'
          else
            'DO NOT SUBMIT'
          end
        end

        def author_name
          @json['author']['name']
        end

        def owner_name
          @json['change']['owner']['name']
        end

        def subject
          @json['change']['subject']
        end

        def url
          @json['change']['url']
        end
      end

      module_function
      def parse(string)
        json = JSON.parse(string)
        if (json["type"] == 'comment-added')
          create_comment_added_message(json)
        end
      end

      def create_comment_added_message(json)
        parsed = CommentAddedJson.new(json)
        "[COMMENT][#{parsed.score}] #{parsed.owner_name} -> #{parsed.author_name} \"#{parsed.subject}\" #{parsed.url}"
      end

    end
  end

end
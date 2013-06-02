module Gerrit
  module Messenger
    module Models
      module CommonEvent

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
    end
  end
end
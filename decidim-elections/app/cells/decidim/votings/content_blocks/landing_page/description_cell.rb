# frozen_string_literal: true

module Decidim
  module Votings
    module ContentBlocks
      module LandingPage
        class DescriptionCell < Decidim::ViewModel
          def show
            content_tag(:div, "VotingDescriptionCell", class:"row column")
          end
        end
      end
    end
  end
end

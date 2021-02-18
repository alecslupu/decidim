# frozen_string_literal: true

module Decidim
  module Votings
    module ContentBlocks
      module LandingPage
        class AttachmentsAndFoldersCell < Decidim::ViewModel
          include Cell::ViewModel::Partial
          include Decidim::IconHelper
          include ActiveSupport::NumberHelper
          include Decidim::AttachmentsHelper

          delegate :current_voting, to: :controller

          def show
            attachments_for current_voting
          end
        end
      end
    end
  end
end

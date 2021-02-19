# frozen_string_literal: true

module Decidim
  module Votings
    module ContentBlocks
      module LandingPage
        class HeaderCell < Decidim::ViewModel
          delegate :current_participatory_space, to: :controller

          private

          def start_time
            content_tag :span, title: t("activemodel.attributes.voting.start_time") do
              format_time(current_participatory_space.start_time)
            end
          end

          def end_time
            content_tag :span, title: t("activemodel.attributes.voting.end_time") do
              format_time(current_participatory_space.end_time)
            end
          end

          def format_time(time)
            if time
              l(time, format: :decidim_short)
            else
              t("decidim.votings.votings_m.unspecified")
            end
          end

          def translated_button_text
            @translated_button_text ||= translated_attribute(model.settings.button_text)
          end

          def translated_button_url
            @translated_button_url ||= translated_attribute(model.settings.button_url)
          end

          def cta_button
            link_to translated_button_text, translated_button_url, class: "button button--sc expanded", title: translated_button_text
          end
        end
      end
    end
  end
end

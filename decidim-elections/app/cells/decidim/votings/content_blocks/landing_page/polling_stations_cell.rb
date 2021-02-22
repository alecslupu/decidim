# frozen_string_literal: true

module Decidim
  module Votings
    module ContentBlocks
      module LandingPage
        class PollingStationsCell < Decidim::ViewModel

          # include Decidim::Elections::Engine.routes.url_helpers
          include Decidim::MapHelper
          include Decidim::SanitizeHelper
          include Decidim::LayoutHelper
          include Decidim::NeedsSnippets
          # include Decidim::Meetings::MapHelper

          # delegate :current_user,
          #         :allowed_to?,
          #         :current_component,
          delegate  :current_participatory_space,
                    to: :controller

          # alias current_participatory_space current_participatory_space

          def show
            return if current_participatory_space.online_voting?

            render
          end

          private

          def polling_stations
            @polling_stations ||= current_participatory_space.polling_stations
          end

          def polling_stations_geocoded
            @polling_stations_geocoded ||= polling_stations.geocoded
          end

          def polling_stations_geocoded_data_for_map
            polling_stations_geocoded.map do |polling_station|
              polling_station.slice(:latitude, :longitude, :address).merge(title: translated_attribute(polling_station.title),
                                                                  #  description: html_truncate(translated_attribute(polling_station.description), length: 200),
                                                                  #  startTimeDay: l(polling_station.start_time, format: "%d"),
                                                                  #  startTimeMonth: l(polling_station.start_time, format: "%B"),
                                                                  #  startTimeYear: l(polling_station.start_time, format: "%Y"),
                                                                  #  startTime: "#{polling_station.start_time.strftime("%H:%M")} - #{polling_station.end_time.strftime("%H:%M")}",
                                                                   icon: "", #icon("meetings", width: 40, height: 70, remove_icon_class: true),
                                                                   location: translated_attribute(polling_station.location),
                                                                   locationHints: decidim_html_escape(translated_attribute(polling_station.location_hints))
                                                                  #  ,
                                                                  #  link: resource_locator(polling_station).path
                                                                )
            end
          end


        end
      end
    end
  end
end

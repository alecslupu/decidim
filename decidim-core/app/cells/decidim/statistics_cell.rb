# frozen_string_literal: true

module Decidim
  # This cell renders the Statistics of a Resource
  class StatisticsCell < Decidim::ViewModel
    private

    def stats
      @stats ||= model
    end

    def stats_heading
      "headline"
      # t("statistics.assemblies.headline", scope: "decidim")
    end

    def no_stats
      "no_stats"
      # t("statistics.assemblies.no_stats", scope: "decidim")
    end
  end
end

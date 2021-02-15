# frozen_string_literal: true

module Decidim
  # This cell renders a Statistic of a Resource
  class StatisticCell < Decidim::ViewModel
    include ActionView::Helpers::NumberHelper

    private

    def stat_number
      number_with_delimiter(model[:stat_number])
    end

    def stat_title
      t(model[:stat_title], scope: "decidim.assemblies.statistics")
    end
  end
end

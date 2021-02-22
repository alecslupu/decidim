# frozen_string_literal: true

module Decidim
  module Elections
    # This cell renders the results
    # for a given instance of an Election
    class ElectionVoteCtaCell < Decidim::ViewModel
      include Decidim::Elections::Engine.routes.url_helpers

      delegate :current_user,
               :allowed_to?,
               :current_component,
               :current_voting,
               to: :controller

      alias current_participatory_space current_voting

      private

      def last_vote
        @last_vote ||= Decidim::Elections::Votes::UserElectionLastVote.new(current_user, model).query
      end

      def vote_action_button
        if !already_voted?
          t("action_button.vote", scope: i18n_scope)
        elsif last_vote_accepted?
          t("action_button.change_vote", scope: i18n_scope)
        else
          t("action_button.vote_again", scope: i18n_scope)
        end
      end

      def callout_text
        if last_vote_accepted?
          t("callout.already-voted", scope: i18n_scope)
        else
          t("callout.vote-rejected", scope: i18n_scope)
        end
      end

      def already_voted?
        last_vote.present?
      end

      def last_vote_accepted?
        !!last_vote&.accepted?
      end

      def i18n_scope
        "decidim.elections.elections.show"
      end
    end
  end
end

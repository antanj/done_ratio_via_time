# Licensed under GNU GPL 2.0
# Author: Tecforce
# Website: http://tecforce.ru

module DoneRatioViaTime
  module Patches
    # Types, patches for done ratio calculations
    module VersionPatch
      def self.included(base)
        base.send(:include, InstanceMethods)
        base.extend(ClassMethods)
        base.class_eval do
          # alias_method_chain :completed_percent, :new_logic
          alias_method :completed_percent_without_new_logic, :completed_percent
          alias_method :completed_percent, :completed_percent_with_new_logic
          # alias_method_chain :closed_percent, :new_logic
          alias_method :closed_percent_without_new_logic, :closed_percent
          alias_method :closed_percent, :closed_percent_with_new_logic
        end
      end

      module ClassMethods
      end

      module InstanceMethods
        def completed_percent_with_new_logic
          issues = Issue.where(fixed_version_id: self.id).where("estimated_hours > ?", "0")
          estinated_hours_sum = issues.map(&:estimated_hours).compact.sum
          spent_hours_sum = TimeEntry.where(issue_id: issues.map(&:id)).map(&:hours).compact.sum
          if estinated_hours_sum == 0
            0
          else
            completed_percent = (100*spent_hours_sum/estinated_hours_sum).to_i
            completed_percent > 100 ? 100 : completed_percent
          end
        end

        def closed_percent_with_new_logic
          all_issues_sum_estimation = Issue.where(fixed_version_id: self.id).map(&:estimated_hours).compact.sum
          completed_issues_sum_estimation = Issue.where(fixed_version_id: self.id).where.not(closed_on: nil).map(&:estimated_hours).compact.sum
          if all_issues_sum_estimation == 0
            0
          else
            closed_percent = (100*completed_issues_sum_estimation/all_issues_sum_estimation).to_i
            closed_percent > 100 ? 100 : closed_percent
          end
        end
      end
    end
  end
end

unless Version.included_modules
            .include?(DoneRatioViaTime::Patches::VersionPatch)
  Version.send(:include, DoneRatioViaTime::Patches::VersionPatch)
end

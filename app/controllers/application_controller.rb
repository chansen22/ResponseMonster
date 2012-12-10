class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  protected

    def authenticate
      redirect_to signin_path unless signed_in?
    end

    def admin_user
      redirect_to root_path unless is_admin?
    end

    def check_permissions(course)
      redirect_to root_path, notice: "You don't have the correct permissions to
       visit this page/do this action" unless is_admin? || course.teacher_id == current_user.id
    end

    def check_activated(survey)
      redirect_to root_path, notice: "That survey is not activated 
      yet" unless survey.is_active? || is_admin? || current_user.id == survey.course.teacher_id
    end
    
    def check_attempts(survey)
      has_permission = false
      assessments = current_user.assessments.where(survey_id: survey.id)
      if survey.attempts_allowed.nil? or survey.attempts_allowed == 0
        has_permission = true
      elsif assessments.empty?
        has_permission = true
      elsif assessments.length < survey.attempts_allowed
        has_permissions = true
      end
      redirect_to course_path(survey.course), notice: "You cannot take this quiz anymore 
      times" unless has_permission || is_admin? || current_user.id == survey.course.teacher_id
    end

    def member_of_course(course)
      is_enrolled = false
      if current_user.id == course.teacher_id
        is_teacher = true
      else
        is_teacher = false
      end
      course.users.each do |user|
        if user == current_user
          is_enrolled = true
        end
      end
      redirect_to root_path, notice: "You must be enrolled in a course to view
      it." unless is_enrolled || is_teacher || is_admin?
    end

    # This should be deprovated
    def check_password(survey)
      can_access = false
      if is_admin?
        can_access = true
      elsif survey.password.nil? || survey.password.empty?
        can_access = true
      elsif current_user.id == survey.course.teacher_id
        can_access = true
      elsif params[:pass] == survey.password
        can_access = true
      end
      redirect_to course_path(survey.course), notice: "The password you entered was not valid or you 
      aren't authorized to visit this quiz" unless can_access
    end
end

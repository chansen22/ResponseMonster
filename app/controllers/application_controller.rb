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
      it." unless is_enrolled || is_teacher
    end
end

module ApplicationHelper
  def current_user
    @current_user
  end

  def vote_active_class(say, value)
    if current_user && current_user.voted?(say)
      if current_user.vote_value(say) == value
        if value == :up
          return 'btn-primary'
        else
          return 'btn-danger'
        end
      end
    end
  end
end

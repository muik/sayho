module ApplicationHelper
  def current_user
    @current_user
  end

  def vote_id(say_id)
    if current_user
      vote = current_user.vote(say_id)
      return vote.id if vote
    end
  end

  def vote_button_tag(say_id, flag)
    active_class = flag.to_sym == :up ? 'btn-primary' : 'btn-danger'
    voted = current_user && current_user.voted?(say_id, flag)

    raw <<HTML
      <a class="btn vote #{(voted ? active_class : '')}" href="#" data-say-id="#{say_id}" data-remote="true" data-value="#{flag}" data-active-class="#{active_class}" data-loading-text="processing.." data-vote-id="#{vote_id(say_id)}">
        <i class="icon-thumbs-up"></i>
        #{flag}
      </a>
HTML
  end
end

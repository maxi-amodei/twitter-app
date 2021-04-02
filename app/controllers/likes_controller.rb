class LikesController < ApplicationController
  def create
    current_user.like(shout)
    redirect_to root_path
  end

  def destroy
    # Tengo el shout id en los params, /shout/:id/unlike, quiero sacar ese shout de los liked_shouts
    current_user.unlike(shout)
    redirect_to root_path
  end

  private
  
  def shout
    # Al ser un member route el url es: /shout/:id/like y NO es shout/shout_id/like
    @_shout ||= Shout.find(params[:id])  
  end
end

class SessionsController < Clearance::SessionsController
# Tengo que reescribir el session controller, heredando del base, para permitir ingresar
#con username o email
  private

  def authenticate(_)
    super(session_params)
  end

  def session_params
    {session: session_params_with_email}
  end
  
  def session_params_with_email
    params.require(:session).permit(:password).merge(email: user.email)
  end

  def user
    User.where(email: email_or_username).or(User.where(username: email_or_username)).first || Guest.new # este or es en caso de que nos devuelva nulo el user, o sea que no exista
  end

  def email_or_username
    params[:session][:email_or_username]
  end
end

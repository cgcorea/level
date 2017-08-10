defmodule Bridge.Email do
  @moduledoc """
  Transactional emails sent by Bridge.
  """

  import Bamboo.Email
  use Bamboo.Phoenix, view: BridgeWeb.EmailView

  @doc """
  The email sent when a user invites another user to join a Bridge team.
  """
  def invitation_email(invitation) do
    team = invitation.team
    invitor = invitation.invitor

    new_email()
    |> to(invitation.email)
    |> from({"Bridge", support_address()})
    |> subject("Your invitation to join the #{team.name} Bridge team")
    |> render("invitation_email.text", invitation: invitation,
                                       team: team,
                                       invitor: invitor)
  end

  def support_address do
    "support@#{Application.get_env(:bridge, :mailer_host)}"
  end
end
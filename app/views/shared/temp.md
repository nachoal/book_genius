
  <!-- Right Navigation -->
  <div class="navbar-wagon-right hidden-xs hidden-sm">

    <% if user_signed_in? %>

      <!-- Links when logged in -->

      <!-- Avatar with dropdown menu -->
      <div class="navbar-wagon-item">
        <div class="dropdown">

          <%= image_tag image_path(current_user.photo_or_default), class: "avatar dropdown-toggle", id: "navbar-wagon-menu", "data-toggle" => "dropdown" %>

          <ul class="dropdown-menu dropdown-menu-right navbar-wagon-dropdown-menu">
            <li>
              <%= link_to user_path(current_user) do %>
                <i class="fa fa-user"></i> <%= t(".profile", default: "Profile") %>
              <% end %>
            </li>
            <li>
              <%= link_to destroy_user_session_path, method: :delete do %>
                <i class="fa fa-sign-out"></i>  <%= t(".sign_out", default: "Log out") %>
              <% end %>
            </li>
          </ul>
        </div>
      </div>
    <% else %>
      <!-- Login link (when logged out) -->

    <% end %>
  </div>

  <!-- Dropdown list appearing on mobile only -->
  <div class="navbar-wagon-item hidden-md hidden-lg">
    <div class="dropdown">
      <i class="fa fa-bars dropdown-toggle" data-toggle="dropdown"></i>
      <ul class="dropdown-menu dropdown-menu-right navbar-wagon-dropdown-menu">
        <li><%= link_to t(".all_collections", default: "Collections"), all_collections_path, class: "navbar-wagon-item navbar-wagon-link" %></li>
        <li><%= link_to t(".sign_up", default: "Signup"), new_user_registration_path, class: "navbar-wagon-item navbar-wagon-link" %></li>
        <li><%= link_to t(".sign_in", default: "Login"), new_user_session_path, class: "navbar-wagon-item navbar-wagon-link" %></li>
      </ul>
    </div>
  </div>

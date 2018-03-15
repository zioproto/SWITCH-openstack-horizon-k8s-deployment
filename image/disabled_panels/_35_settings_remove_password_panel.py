##
# Disable the user 'Change Password' panel
#
# FILE: _60_settings_remove_password_panel.py
#
# INSTALL:
# cp _60_settings_remove_password_panel.py /usr/share/openstack-dashboard/openstack_dashboard/enabled/
# /usr/share/openstack-dashboard/manage.py compress
##
# The name of the dashboard the PANEL associated with. Required.
PANEL_DASHBOARD = 'settings'
# The name of the panel group the PANEL is associated with.
PANEL_GROUP = 'settings'
# The name of the panel to be removed from HORIZON_CONFIG. Required.
PANEL = 'password'

# If set to True, the panel will be removed from PANEL_DASHBOARD/PANEL_GROUP.
REMOVE_PANEL = True

FROM ubuntu:16.04
MAINTAINER Saverio Proto <saverio.proto@switch.ch>
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys AE0AF310E2EA96B6B6F4BD726F8600B9563278F6
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 5EDB1B62EC4926EA
COPY requirements.txt /requirements.txt
RUN set -x \
    && echo "deb http://ubuntu-cloud.archive.canonical.com/ubuntu xenial-updates/pike main" > /etc/apt/sources.list.d/pike.list \
    && apt-get -y update \
    && apt-get -y install python-django-horizon openstack-dashboard python-pymysql python-pip python-django-websocket-redis \
    && apt-get -y install git \
    && apt-get -y clean \
    && pip install -r /requirements.txt \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
COPY lp1744239.patch /lp1744239.patch
COPY lp1699724.patch /lp1699724.patch
WORKDIR /usr/share/openstack-dashboard
RUN patch -p1 < /lp1744239.patch
RUN rm openstack_dashboard/utils/settings.pyc
RUN python -m py_compile openstack_dashboard/utils/settings.py
WORKDIR /usr/share/openstack-dashboard
RUN patch -p1 < /lp1699724.patch
RUN rm openstack_dashboard/api/neutron.pyc
RUN python -m py_compile openstack_dashboard/api/neutron.py
WORKDIR /root
COPY img/logo.svg /var/lib/openstack-dashboard/static/dashboard/img/logo.svg
COPY img/logo-splash.svg /var/lib/openstack-dashboard/static/dashboard/img/logo-splash.svg
COPY img/favicon.ico /var/lib/openstack-dashboard/static/dashboard/img/favicon.ico
COPY themes/default/img/logo-switch.png /usr/share/openstack-dashboard/openstack_dashboard/themes/default/img/logo-switch.png
COPY themes/default/img/logo-switchengines.png /usr/share/openstack-dashboard/openstack_dashboard/themes/default/img/logo-switchengines.png
COPY themes/default/templates/auth/_footer_switch.html /usr/share/openstack-dashboard/openstack_dashboard/themes/default/templates/auth/_footer_switch.html
COPY themes/default/templates/auth/_login_page.html /usr/share/openstack-dashboard/openstack_dashboard/themes/default/templates/auth/_login_page.html
COPY themes/default/templates/auth/_splash.html /usr/share/openstack-dashboard/openstack_dashboard/themes/default/templates/auth/_splash.html
COPY 15-horizon_vhost.conf /etc/apache2/sites-enabled/
COPY entrypoint.sh /entrypoint.sh
COPY local_settings.py /etc/openstack-dashboard/local_settings.py
COPY disabled_panels/_35_settings_remove_password_panel.py /usr/share/openstack-dashboard/openstack_dashboard/enabled/_35_settings_remove_password_panel.py
COPY disabled_panels/_1330_project_backups_panel.py /usr/share/openstack-dashboard/openstack_dashboard/enabled/_1330_project_backups_panel.py
COPY disabled_panels/_1340_project_consistency_groups_panel.py /usr/share/openstack-dashboard/openstack_dashboard/enabled/_1340_project_consistency_groups_panel.py
COPY disabled_panels/_1350_project_cg_snapshots_panel.py /usr/share/openstack-dashboard/openstack_dashboard/enabled/_1350_project_cg_snapshots_panel.py
RUN mkdir -p /var/log/horizon/ && touch /var/log/horizon/horizon.log && chown -R horizon:horizon /var/log/horizon/
#RUN /usr/share/openstack-dashboard/manage.py collectstatic --noinput
#RUN /usr/share/openstack-dashboard/manage.py compress --force
RUN a2enmod rewrite
RUN sed -i "s/%h/%{X-Forwarded-For}i %h/" /etc/apache2/apache2.conf
RUN sed -i "s/Listen 80/Listen 8080/" /etc/apache2/ports.conf
EXPOSE 8080
RUN chown root.root /entrypoint.sh && chmod a+x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

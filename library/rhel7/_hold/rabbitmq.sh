#!/bin/bash
# NEEDS WORK, Most works until the Pivotal JMS Connector

yum -y install erlang
rpm -Uvh https://github.com/rabbitmq/rabbitmq-server/releases/download/rabbitmq_v3_5_1/rabbitmq-server-3.5.1-1.noarch.rpm
cat << EOF >> /etc/rabbitmq/rabbitmq-env.conf 
NODENAME=rabbit@dflgnvbaty1
CONFIG_FILE=/etc/rabbitmq/rabbitmq
EOF
cat << EOF >> /etc/rabbitmq/rabbitmq.config
%% -*- mode: erlang -*-
%% ----------------------------------------------------------------------------
%% RabbitMQ Sample Configuration File.
%%
%% See http://www.rabbitmq.com/configure.html for details.
%% ----------------------------------------------------------------------------
[
 {rabbit,
  [%%
   %% Network Connectivity
   %% ====================
   %%

   %% By default, RabbitMQ will listen on all interfaces, using
   %% the standard (reserved) AMQP port.
   %%
   
   {tcp_listeners, [5674]},

   %% To listen on a specific interface, provide a tuple of {IpAddress, Port}.
   %% For example, to listen only on localhost for both IPv4 and IPv6:
   %%
   %% {tcp_listeners, [{"127.0.0.1", 5672},
   %%                  {"::1",       5672}]},

   %% SSL listeners are configured in the same fashion as TCP listeners,
   %% including the option to control the choice of interface.
   %%
   %% {ssl_listeners, [5671]},

   %% Log levels (currently just used for connection logging).
   %% One of 'info', 'warning', 'error' or 'none', in decreasing order
   %% of verbosity. Defaults to 'info'.
   %%
   %% {log_levels, [{connection, info}]},

   %% Set to 'true' to perform reverse DNS lookups when accepting a
   %% connection. Hostnames will then be shown instead of IP addresses
   %% in rabbitmqctl and the management plugin.
   %%
   
   {reverse_dns_lookups, true},

   {loopback_users, []},

   %%
   %% Security / AAA
   %% ==============
   %%

   %% Configuring SSL.
   %% See http://www.rabbitmq.com/ssl.html for full documentation.
   %%
   %% {ssl_options, [{cacertfile,           "/path/to/testca/cacert.pem"},
   %%                {certfile,             "/path/to/server/cert.pem"},
   %%                {keyfile,              "/path/to/server/key.pem"},
   %%                {verify,               verify_peer},
   %%                {fail_if_no_peer_cert, false}]},

   %% Choose the available SASL mechanism(s) to expose.
   %% The two default (built in) mechanisms are 'PLAIN' and
   %% 'AMQPLAIN'. Additional mechanisms can be added via
   %% plugins.
   %%
   %% See http://www.rabbitmq.com/authentication.html for more details.
   %%
   %% {auth_mechanisms, ['PLAIN', 'AMQPLAIN']},

   %% Select an authentication database to use. RabbitMQ comes bundled
   %% with a built-in auth-database, based on mnesia.
   %%
   %% {auth_backends, [rabbit_auth_backend_internal]},

   %% Configurations supporting the rabbitmq_auth_mechanism_ssl and
   %% rabbitmq_auth_backend_ldap plugins.
   %%
   %% NB: These options require that the relevant plugin is enabled.
   %% See http://www.rabbitmq.com/plugins.html for further details.

   %% The RabbitMQ-auth-mechanism-ssl plugin makes it possible to
   %% authenticate a user based on the client's SSL certificate.
   %%
   %% To use auth-mechanism-ssl, add to or replace the auth_mechanisms
   %% list with the entry 'EXTERNAL'.
   %%
   %% {auth_mechanisms, ['EXTERNAL']},

   %% The rabbitmq_auth_backend_ldap plugin allows the broker to
   %% perform authentication and authorisation by deferring to an
   %% external LDAP server.
   %%
   %% For more information about configuring the LDAP backend, see
   %% http://www.rabbitmq.com/ldap.html.
   %%
   %% Enable the LDAP auth backend by adding to or replacing the
   %% auth_backends entry:
   %%
   %% {auth_backends, [rabbit_auth_backend_ldap]},

   %% This pertains to both the rabbitmq_auth_mechanism_ssl plugin and
   %% STOMP ssl_cert_login configurations. See the rabbitmq_stomp
   %% configuration section later in this fail and the README in
   %% https://github.com/rabbitmq/rabbitmq-auth-mechanism-ssl for further
   %% details.
   %%
   %% To use the SSL cert's CN instead of its DN as the username
   %%
   %% {ssl_cert_login_from, common_name},

   %%
   %% Default User / VHost
   %% ====================
   %%

   %% On first start RabbitMQ will create a vhost and a user. These
   %% config items control what gets created. See
   %% http://www.rabbitmq.com/access-control.html for further
   %% information about vhosts and access control.
   %%
   %% {default_vhost,       <<"/">>},

   {default_user,        <<"rabbitmq">>},
   {default_pass,        <<"bunniesare4EVER">>}

   %% {default_permissions, [<<".*">>, <<".*">>, <<".*">>]},

   %% Tags for default user
   %%
   %% For more details about tags, see the documentation for the
   %% Management Plugin at http://www.rabbitmq.com/management.html.
   %%
   %% {default_user_tags, [administrator]},

   %%
   %% Additional network and protocol related configuration
   %% =====================================================
   %%

   %% Set the default AMQP heartbeat delay (in seconds).
   %%
   %% {heartbeat, 600},

   %% Set the max permissible size of an AMQP frame (in bytes).
   %%
   %% {frame_max, 131072},

   %% Customising Socket Options.
   %%
   %% See (http://www.erlang.org/doc/man/inet.html#setopts-2) for
   %% further documentation.
   %%
   %% {tcp_listen_options, [binary,
   %%                       {packet,        raw},
   %%                       {reuseaddr,     true},
   %%                       {backlog,       128},
   %%                       {nodelay,       true},
   %%                       {exit_on_close, false}]},

   %%
   %% Resource Limits & Flow Control
   %% ==============================
   %%
   %% See http://www.rabbitmq.com/memory.html for full details.

   %% Memory-based Flow Control threshold.
   %%
   %% {vm_memory_high_watermark, 0.4},

   %% Fraction of the high watermark limit at which queues start to
   %% page message out to disc in order to free up memory.
   %%
   %% {vm_memory_high_watermark_paging_ratio, 0.5},

   %% Set disk free limit (in bytes). Once free disk space reaches this
   %% lower bound, a disk alarm will be set - see the documentation
   %% listed above for more details.
   %%
   %% {disk_free_limit, 50000000},

   %% Alternatively, we can set a limit relative to total available RAM.
   %%
   %% {disk_free_limit, {mem_relative, 1.0}},

   %%
   %% Misc/Advanced Options
   %% =====================
   %%
   %% NB: Change these only if you understand what you are doing!
   %%

   %% To announce custom properties to clients on connection:
   %%
   %% {server_properties, []},

   %% How to respond to cluster partitions.
   %% See http://www.rabbitmq.com/partitions.html for further details.
   %%
   %% {cluster_partition_handling, ignore},

   %% Make clustering happen *automatically* at startup - only applied
   %% to nodes that have just been reset or started for the first time.
   %% See http://www.rabbitmq.com/clustering.html#auto-config for
   %% further details.
   %%
   %% {cluster_nodes, {['rabbit@my.host.com'], disc}},

   %% Set (internal) statistics collection granularity.
   %%
   %% {collect_statistics, none},

   %% Statistics collection interval (in milliseconds).
   %%
   %% {collect_statistics_interval, 5000},

   %% Explicitly enable/disable hipe compilation.
   %%
   %% {hipe_compile, true}

  ]},

 %% ----------------------------------------------------------------------------
 %% Advanced Erlang Networking/Clustering Options.
 %%
 %% See http://www.rabbitmq.com/clustering.html for details
 %% ----------------------------------------------------------------------------
 {kernel,
  [%% Provide an explicit port-range for inter-node communications.
   %% See http://www.rabbitmq.com/clustering.html#firewall for further details.

   %% Sets the minimum / maximum port numbers
   %%
   %% {inet_dist_listen_min, 10000},
   %% {inet_dist_listen_max, 10005},

   %% Sets the net_kernel tick time.
   %% Please see http://erlang.org/doc/man/kernel_app.html and
   %% http://www.rabbitmq.com/nettick.html for further details.
   %%
   %% {net_ticktime, 60}
  ]},

 %% ----------------------------------------------------------------------------
 %% RabbitMQ Management Plugin
 %%
 %% See http://www.rabbitmq.com/management.html for details
 %% ----------------------------------------------------------------------------

 {rabbitmq_management,
  [%% Pre-Load schema definitions from the following JSON file. See
   %% http://www.rabbitmq.com/management.html#load-definitions
   %%
   %% {load_definitions, "/path/to/schema.json"},

   %% Log all requests to the management HTTP API to a file.
   %%
   %% {http_log_dir, "/path/to/access.log"},

   %% Change the port on which the HTTP listener listens,
   %% specifying an interface for the web server to bind to.
   %% Also set the listener to use SSL and provide SSL options.
   %%
   %% {listener, [{port,     12345},
   %%             {ip,       "127.0.0.1"},
   %%             {ssl,      true},
   %%             {ssl_opts, [{cacertfile, "/path/to/cacert.pem"},
   %%                         {certfile,   "/path/to/cert.pem"},
   %%                         {keyfile,    "/path/to/key.pem"}]}]},

   %% Configure how long aggregated data (such as message rates and queue
   %% lengths) is retained. Please read the plugin's documentation in
   %% https://www.rabbitmq.com/management.html#configuration for more
   %% details.
   %%
   %% {sample_retention_policies,
   %%  [{global,   [{60, 5}, {3600, 60}, {86400, 1200}]},
   %%   {basic,    [{60, 5}, {3600, 60}]},
   %%   {detailed, [{10, 5}]}]}
  ]},

 {rabbitmq_management_agent,
  [%% Misc/Advanced Options
   %%
   %% NB: Change these only if you understand what you are doing!
   %%
   %% {force_fine_statistics, true}
  ]},

 %% ----------------------------------------------------------------------------
 %% RabbitMQ Shovel Plugin
 %%
 %% See http://www.rabbitmq.com/shovel.html for details
 %% ----------------------------------------------------------------------------

 {rabbitmq_shovel,
  [{shovels,
    [%% A named shovel worker.
     %% {my_first_shovel,
     %%  [

     %% List the source broker(s) from which to consume.
     %%
     %%   {sources,
     %%    [%% URI(s) and pre-declarations for all source broker(s).
     %%     {brokers, ["amqp://user:password@host.domain/my_vhost"]},
     %%     {declarations, []}
     %%    ]},

     %% List the destination broker(s) to publish to.
     %%   {destinations,
     %%    [%% A singular version of the 'brokers' element.
     %%     {broker, "amqp://"},
     %%     {declarations, []}
     %%    ]},

     %% Name of the queue to shovel messages from.
     %%
     %% {queue, <<"your-queue-name-goes-here">>},

     %% Optional prefetch count.
     %%
     %% {prefetch_count, 10},

     %% when to acknowledge messages:
     %% - no_ack: never (auto)
     %% - on_publish: after each message is republished
     %% - on_confirm: when the destination broker confirms receipt
     %%
     %% {ack_mode, on_confirm},

     %% Overwrite fields of the outbound basic.publish.
     %%
     %% {publish_fields, [{exchange,    <<"my_exchange">>},
     %%                   {routing_key, <<"from_shovel">>}]},

     %% Static list of basic.properties to set on re-publication.
     %%
     %% {publish_properties, [{delivery_mode, 2}]},

     %% The number of seconds to wait before attempting to
     %% reconnect in the event of a connection failure.
     %%
     %% {reconnect_delay, 2.5}

     %% ]} %% End of my_first_shovel
    ]}
   %% Rather than specifying some values per-shovel, you can specify
   %% them for all shovels here.
   %%
   %% {defaults, [{prefetch_count,     0},
   %%             {ack_mode,           on_confirm},
   %%             {publish_fields,     []},
   %%             {publish_properties, [{delivery_mode, 2}]},
   %%             {reconnect_delay,    2.5}]}
  ]},

 %% ----------------------------------------------------------------------------
 %% RabbitMQ Stomp Adapter
 %%
 %% See http://www.rabbitmq.com/stomp.html for details
 %% ----------------------------------------------------------------------------

 {rabbitmq_stomp,
  [%% Network Configuration - the format is generally the same as for the broker

   %% Listen only on localhost (ipv4 & ipv6) on a specific port.
   %% {tcp_listeners, [{"127.0.0.1", 61613},
   %%                  {"::1",       61613}]},

   %% Listen for SSL connections on a specific port.
   %% {ssl_listeners, [61614]},

   %% Additional SSL options

   %% Extract a name from the client's certificate when using SSL.
   %%
   %% {ssl_cert_login, true},

   %% Set a default user name and password. This is used as the default login
   %% whenever a CONNECT frame omits the login and passcode headers.
   %%
   %% Please note that setting this will allow clients to connect without
   %% authenticating!
   %%
   %% {default_user, [{login,    "guest"},
   %%                 {passcode, "guest"}]},

   %% If a default user is configured, or you have configured use SSL client
   %% certificate based authentication, you can choose to allow clients to
   %% omit the CONNECT frame entirely. If set to true, the client is
   %% automatically connected as the default user or user supplied in the
   %% SSL certificate whenever the first frame sent on a session is not a
   %% CONNECT frame.
   %%
   %% {implicit_connect, true}
  ]},

 %% ----------------------------------------------------------------------------
 %% RabbitMQ MQTT Adapter
 %%
 %% See http://hg.rabbitmq.com/rabbitmq-mqtt/file/stable/README.md for details
 %% ----------------------------------------------------------------------------

 {rabbitmq_mqtt,
  [%% Set the default user name and password. Will be used as the default login
   %% if a connecting client provides no other login details.
   %%
   %% Please note that setting this will allow clients to connect without
   %% authenticating!
   %%
   %% {default_user, <<"guest">>},
   %% {default_pass, <<"guest">>},

   %% Enable anonymous access. If this is set to false, clients MUST provide
   %% login information in order to connect. See the default_user/default_pass
   %% configuration elements for managing logins without authentication.
   %%
   %% {allow_anonymous, true},

   %% If you have multiple chosts, specify the one to which the
   %% adapter connects.
   %%
   %% {vhost, <<"/">>},

   %% Specify the exchange to which messages from MQTT clients are published.
   %%
   %% {exchange, <<"amq.topic">>},

   %% Specify TTL (time to live) to control the lifetime of non-clean sessions.
   %%
   %% {subscription_ttl, 1800000},

   %% Set the prefetch count (governing the maximum number of unacknowledged
   %% messages that will be delivered).
   %%
   %% {prefetch, 10},

   %% TCP/SSL Configuration (as per the broker configuration).
   %%
   %% {tcp_listeners, [1883]},
   %% {ssl_listeners, []},

   %% TCP/Socket options (as per the broker configuration).
   %%
   %% {tcp_listen_options, [binary,
   %%                       {packet,    raw},
   %%                       {reuseaddr, true},
   %%                       {backlog,   128},
   %%                       {nodelay,   true}]}
  ]},

 %% ----------------------------------------------------------------------------
 %% RabbitMQ AMQP 1.0 Support
 %%
 %% See http://hg.rabbitmq.com/rabbitmq-amqp1.0/file/default/README.md
 %% for details
 %% ----------------------------------------------------------------------------

 {rabbitmq_amqp1_0,
  [%% Connections that are not authenticated with SASL will connect as this
   %% account. See the README for more information.
   %%
   %% Please note that setting this will allow clients to connect without
   %% authenticating!
   %%
   %% {default_user, "guest"},

   %% Enable protocol strict mode. See the README for more information.
   %%
   %% {protocol_strict_mode, false}
  ]},

 %% ----------------------------------------------------------------------------
 %% RabbitMQ LDAP Plugin
 %%
 %% See http://www.rabbitmq.com/ldap.html for details.
 %%
 %% ----------------------------------------------------------------------------

 {rabbitmq_auth_backend_ldap,
  [%%
   %% Connecting to the LDAP server(s)
   %% ================================
   %%

   %% Specify servers to bind to. You *must* set this in order for the plugin
   %% to work properly.
   %%
   %% {servers, ["your-server-name-goes-here"]},

   %% Connect to the LDAP server using SSL
   %%
   %% {use_ssl, false},

   %% Specify the LDAP port to connect to
   %%
   %% {port, 389},

   %% Enable logging of LDAP queries.
   %% One of
   %%   - false (no logging is performed)
   %%   - true (verbose logging of the logic used by the plugin)
   %%   - network (as true, but additionally logs LDAP network traffic)
   %%
   %% Defaults to false.
   %%
   %% {log, false},

   %%
   %% Authentication
   %% ==============
   %%

   %% Pattern to convert the username given through AMQP to a DN before
   %% binding
   %%
   %% {user_dn_pattern, "cn=${username},ou=People,dc=example,dc=com"},

   %% Alternatively, you can convert a username to a Distinguished
   %% Name via an LDAP lookup after binding. See the documentation for
   %% full details.

   %% When converting a username to a dn via a lookup, set these to
   %% the name of the attribute that represents the user name, and the
   %% base DN for the lookup query.
   %%
   %% {dn_lookup_attribute,   "userPrincipalName"},
   %% {dn_lookup_base,        "DC=gopivotal,DC=com"},

   %% Controls how to bind for authorisation queries and also to
   %% retrieve the details of users logging in without presenting a
   %% password (e.g., SASL EXTERNAL).
   %% One of
   %%  - as_user (to bind as the authenticated user - requires a password)
   %%  - anon    (to bind anonymously)
   %%  - {UserDN, Password} (to bind with a specified user name and password)
   %%
   %% Defaults to 'as_user'.
   %%
   %% {other_bind, as_user},

   %%
   %% Authorisation
   %% =============
   %%

   %% The LDAP plugin can perform a variety of queries against your
   %% LDAP server to determine questions of authorisation. See
   %% http://www.rabbitmq.com/ldap.html#authorisation for more
   %% information.

   %% Set the query to use when determining vhost access
   %%
   %% {vhost_access_query, {in_group,
   %%                       "ou=${vhost}-users,ou=vhosts,dc=example,dc=com"}},

   %% Set the query to use when determining resource (e.g., queue) access
   %%
   %% {resource_access_query, {constant, true}},

   %% Set queries to determine which tags a user has
   %%
   %% {tag_queries, []}
  ]}
].
EOF
cd /tmp
wget http://thirdparty.thig.com/vmware/rabbit/rabbitmq-jms-package-1.0.5-client-and-plugin.zip
unzip rabbitmq-jms-package-1.0.5-client-and-plugin.zip plugin/rjms-topic-selector-1.0.5.ez -d /usr/lib/rabbitmq/plugin
service rabbitmq-server start
chkconfig rabbitmq-server on
sleep 10
rabbitmq-plugins enable rabbitmq_management
rabbitmq-plugins enable rabbitmq_management_visualiser
rabbitmq-plugins enable rabbitmq_shovel
rabbitmq-plugins enable rabbitmq_shovel_management
#rabbitmq-plugins enable rabbitmq_jms_topic_exchange

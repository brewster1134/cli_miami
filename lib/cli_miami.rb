#
# DO NOT CHANGE THIS FILE FOR CORE CLI_MIAMI INIT FUNCTIONS!
#
# This file is used only for augmenting the core classes with global aliases.
# This lets users use CLI Miami without having to pollute their global namespace
#
# the core initilization runs from `namespaced.rb`
require 'namespaced'

# create alias classes to support `A.sk` and `S.ay` syntax
A = CliMiami::A
S = CliMiami::S

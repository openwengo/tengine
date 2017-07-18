
# Copyright (C) Igor Sysoev
# Copyright (C) Nginx, Inc.

use 5.006001;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME              => 'tengine',
    VERSION_FROM      => 'tengine.pm',     # finds $VERSION
    PREREQ_PM         => {},             # e.g., Module::Name => 1.1

    ABSTRACT_FROM     => 'tengine.pm',     # retrieve abstract from module
    AUTHOR            => 'Igor Sysoev',

    CCFLAGS           => "$ENV{NGX_PM_CFLAGS}",
    OPTIMIZE          => '-O',

    INC               => join(" ", map {
                             m#^/# ? "-I $_" : "-I ../../../../../$_"
                         } (split /\s+/, $ENV{NGX_INCS})),

    depend => {
        'nginx.c'     => join(" ", map {
                             m#^/# ? $_ : "../../../../../$_"
                         } (split(/\s+/, $ENV{NGX_DEPS}),
                            "src/http/modules/perl/ngx_http_perl_module.h"))
    },

    PM => {
        'tengine.pm'    => '$(INST_LIBDIR)/tengine.pm'
    }
);

pkg_name=concourse-web
pkg_origin=eeyun
pkg_version="0.1.0"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2.0')
pkg_description="CI that scales with your project"
pkg_upstream_url="https://concourse.ci"
pkg_deps=(core/concourse core/postgresql)
pkg_svc_group="root"
pkg_svc_user="root"
pkg_exports=(
   [web_port]=ports.web
)
pkg_exposes=(web_port)
pkg_binds_optional=(
   [database]="web_port host"
)

do_build(){
  return 0
}

do_install(){
  return 0
}
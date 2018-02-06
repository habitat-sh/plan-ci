pkg_name=concourse-worker
pkg_origin=eeyun
pkg_version="0.1.0"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2.0')
pkg_description="CI that scales with your project"
pkg_upstream_url="https://concourse.ci"
pkg_svc_group="root"
pkg_svc_user="root"
pkg_deps=(core/concourse core/iptables core/bash core/findutils)
pkg_binds_optional=(
   [web]="host"
)

do_build(){
  return 0
}

do_install(){
  return 0
}
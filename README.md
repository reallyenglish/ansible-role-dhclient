# ansible-role-dhclient

A brief description of the role goes here.

# Requirements

None

# Role Variables

| Variable | Description | Default |
|----------|-------------|---------|
| dhclient\_config\_file | path to `dhclient.conf(5)` | {{ \_\_dhclient\_config\_file }} |
| dhclient\_config | array of configurations | [] |
| dhclient\_service | service name | {{ \_\_dhclient\_service }} |
| dhclient\_interface | the interface on which `dhclient` is enabled | "" |

## Debian

| Variable | Default |
|----------|---------|
| \_\_dhclient\_config\_file | /etc/dhcp/dhclient.conf |

## FreeBSD

| Variable | Default |
|----------|---------|
| \_\_dhclient\_config\_file | /etc/dhclient.conf |
| \_\_dhclient\_service | dhclient |

## OpenBSD

| Variable | Default |
|----------|---------|
| \_\_dhclient\_config\_file | /etc/dhclient.conf |
| \_\_dhclient\_service | dhclient |

## RedHat

| Variable | Default |
|----------|---------|
| \_\_dhclient\_config\_file | /etc/dhcp/dhclient.conf |
| \_\_dhclient\_service | "" |

Created by [yaml2readme.rb](https://gist.github.com/trombik/b2df709657c08d845b1d3b3916e592d3)

# Dependencies

None

# Example Playbook

```yaml
- hosts: localhost
  roles:
    - ansible-role-dhclient
  vars:
    name_servers:
      - 8.8.8.8
      - 8.8.4.4
    dhclient_interface: "{% if ansible_os_family == 'FreeBSD' %}em0{% elif ansible_os_family == 'Debian' %}eth0{% elif ansible_os_family == 'OpenBSD' %}em0{% endif %}"
    dhclient_config:
      - "supersede domain-name-servers {{ name_servers | predictable_shuffle(ansible_fqdn) | join(',') }};"
```

# License

```
Copyright (c) 2016 Tomoyuki Sakurai <tomoyukis@reallyenglish.com>

Permission to use, copy, modify, and distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
```

# Author Information

Tomoyuki Sakurai <tomoyukis@reallyenglish.com>

This README was created by [ansible-role-init](https://gist.github.com/trombik/d01e280f02c78618429e334d8e4995c0)

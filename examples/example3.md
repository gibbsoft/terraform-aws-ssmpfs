### Example 3 : Retrieving chunked files via Ansbile

This terraform module's `value` output has the complete secret, however often
you may wish to retrieve and reconstitute a chunked file via a configuration
management tool, such as Ansible.

This small example reaches into to SSM and pulls out all the child SSM params
for an entry point, sorts them and joins them back together in the right order,
which it then writes to a local file. It leverages the [ssmpfs ansible role](https://galaxy.ansible.com/gibbsoft/ssmpfs).

```yaml
  roles:
    - role: gibbsoft.ssmpfs
      key: /LoremIpsum
      dest: output.txt
```


<https://galaxy.ansible.com/gibbsoft/ssmpfs>

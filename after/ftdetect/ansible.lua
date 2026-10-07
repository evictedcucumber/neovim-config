vim.filetype.add({
    pattern = {
        ['.*/playbooks/.*%.yml'] = 'yaml.ansible',
        ['.*/inventory/.*%.yml'] = 'yaml.ansible',
        ['.*/group_vars/.*%.yml'] = 'yaml.ansible',
        ['.*/host_vars/.*%.yml'] = 'yaml.ansible',
        ['.*/roles/.*%.yml'] = 'yaml.ansible',
    },
})

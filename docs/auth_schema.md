# Auth Schema MongoDB

Main objectives:

* Provide controlled access to resources
	* Queries

Account Type | Permissions
-------------|----------------
admin        | Manage accounts
manager      | Manage roles
user         | Poor bastards

## Permissions

### Accounts:

Every account represents an user to the system.

List, create, retrieve, update, delete accounts.

### Roles:
List, create, retrieve, update, delete roles.


## MongoDB data

### Users

```javascript
{
	'display_name': 'Leonardo Meirelles',
	'email': 'pitecus@gmail.com',
	'status': 'enable',
	'type': 'admin'
}
```

Field | Type | Description
---|---|---
display_name | String | The name to be used in the screen
email | String | The account's email
status | String | The status of the account. It can be active, inactive
type | String | The account type. It can be admin, manager or user.

### Resources

```javascript
{
	'title': 'Account',
	'type': 'navbar',
	'menu': 'settings/account',
	'rest': '/api/v1/account',
	'path': '/setting/account'
}
```

### Roles

```javascript
{
	'name': '',
	'description': '',
	'type': '',
	'resource': '',
	'users_ids': [],
	'permissions': [
		{
			'resource': {
				
			},
			'can_create': true,
			'can_read': true,
			'can_update': true,
			'can_delete': true
		}
	]
}
```
This is a [packer](https://packer.io) project.

### To use this project

Edit `template.json` and replace the variables on top:

```json
    "push": {
      "name": "alvaro/ubuntu1402-ruby222",
      "vcs": false
    },
    "variables": {
        "atlas_username": "alvaro",
        "atlas_name": "ubuntu1402-ruby222"
    },
```
Set `ATLAS_TOKEN` variable, and run:
  
`packer push template.json` to have atlas to build your box
  
`packer build template.json` to build this box locally
  
After a sucessful run, the vagrant boxes will be uplodaded to atlas, under `atlas_username/atlas_name`

If you don't have yet a user in [atlas](https://atlas.hashicorp.com), go to their website and create one:
[https://atlas.hashicorp.com](https://atlas.hashicorp.com)

If you haven't created a token yet, go to the atlas page to create a token [https://atlas.hashicorp.com/settings/tokens](https://atlas.hashicorp.com/settings/tokens)

  
### modifying this project
 
Have a look at `template.json` and the `scripts/` folder.
 
After you do your chances, you need to increase the version manually on `template.json`
 
ie: 
 
```json
  "version": "0.0.3"
```
 

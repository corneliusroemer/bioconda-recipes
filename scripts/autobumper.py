#%%
import requests
import json
import re
import hashlib
#%%
# Get latest version of Nextclade
r = requests.get("https://api.github.com/repos/nextstrain/nextclade/releases/latest")
nextclade_latest = json.loads(r.content)
latest_version = nextclade_latest["tag_name"]

#%%
with open("version.txt", "w") as f:
    f.write(latest_version)

# #%%
# nextclade_latest["assets"]
# # %%
# # If branch exists don't do anything
# r = requests.get("https://api.github.com/repos/corneliusroemer/bioconda-recipes/branches/update/nextclade")
# j = json.loads(r.content)
# j
# #%%
# # Download recipe from master
# r = requests.get("https://raw.githubusercontent.com/corneliusroemer/bioconda-recipes/master/recipes/nextclade/meta.yaml")
# s = r.content.decode("utf-8")
# m = re.search(r'version = "(.+)"', s)
# current_version = m.group(1)

# # %%
# # Get sha of assets
# shas = {}
# for asset in nextclade_latest["assets"]:
#     r = requests.get(asset["url"], headers={"Accept": "application/octet-stream"})
#     h = hashlib.sha256()
#     h.update(r.content)
#     shas[asset["name"]] = h.hexdigest()
# print(shas)

# # %%
# regex = r'sha256: (\S+)\s+# \[linux64\]'
# m = re.search(regex, s)
# print(m[1])
# # %%
# copy = s
# re.sub(regex, shas['nextalign-Linux-x86_64'], copy)
# # %%
# # Create branch
# # Reset to upstream master
# # Write updated recipe
# # Commit
# # Create PR
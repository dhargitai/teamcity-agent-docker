If you started the TeamCity server like this:
```console
docker run -dt --name teamcity_server_1 diatigrah/teamcity-server
```
then you should start the agent like this:
```console
docker run --name teamcity_agent_1 --link teamcity_server_1:SERVER -d diatigrah/teamcity-agent
```
Please note that it will work (and start) only if you've set up the server before.

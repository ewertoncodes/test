```bash
git clone git@github.com:ewertoncodes/test.git
cd test
touch .env
docker compose run web rails db:setup
docker compose up
```

If you want see tests:

```bash
docker compose run web rspec
```
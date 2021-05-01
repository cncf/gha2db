select
  org.login as org,
  repo.name as repo,
  repo.id as rid,
  min(created_at) as date_from,
  max(created_at) as date_to
from (
  select * from
    [githubarchive:month.202104],
    [githubarchive:month.202103],
    [githubarchive:month.202102],
    [githubarchive:month.202101]
    [githubarchive:year.2020],
    [githubarchive:year.2019],
    [githubarchive:year.2018],
    [githubarchive:year.2017],
    [githubarchive:year.2016],
    [githubarchive:year.2015],
    [githubarchive:year.2014]
 )
where
  repo.id in (
    select
      repo.id
    from
      [githubarchive:month.202104],
      [githubarchive:month.202103],
      [githubarchive:month.202102],
      [githubarchive:month.202101]
      [githubarchive:year.2020],
    where
      repo.name like 'org_name/%'
    group by
      repo.id
  )
group by
  org, repo, rid
order by
  date_from
;

-- Add repository groups

update gha_repos set repo_group = null;
update gha_repos set repo_group = 'GraphQL JavaScript' where name = 'graphql/graphql-js';
update gha_repos set repo_group = 'GraphQL IDE' where name = 'graphql/graphiql';
update gha_repos set repo_group = 'Express GraphQL' where name = 'graphql/express-graphql';
update gha_repos set repo_group = 'GraphQL Spec' where name in ('graphql/graphql-spec', 'facebook/graphql');

update
  gha_repos r
set
  alias = coalesce((
    select e.dup_repo_name
    from
      gha_events e
    where
      e.repo_id = r.id
    order by
      e.created_at desc
    limit 1
  ), name)
where
  r.name like '%_/_%'
  and r.name not like '%/%/%'
;

select
  repo_group,
  count(*) as number_of_repos
from
  gha_repos
where
  repo_group is not null
group by
  repo_group
order by
  number_of_repos desc,
  repo_group asc;

# SBLWWDictionary

### Improvments

- resultingNodes/resultingElements could be generated in a more cost effective way, caching them and updating them as we go or just replaying the last operation since last fetch
- won't contain the history of changes, as dictionnary keys are the values, so only one add/remove per value in history -- it's by design but might be useful to have the history in practice
- timestamps are used as node unique identifiers, there could be collisions even if unlikely, should make that more robust

- If needed add pure methods versions as for the merging (used in tests)
- Enabled code coverage locally : should add more test and fix the uncovered cases (Like removals in merge, quite big!)

const accountsToRemove = ['maitland'];

const filterAccounts = stateAccounts =>
    Object.keys(stateAccounts)
        .filter(name => !accountsToRemove.includes(name))
        .reduce(
            (acc, cur) => ({
                ...acc,
                [cur]: stateAccounts[cur],
            }),
            {}
        );

const filterContent = stateContent =>
    Object.keys(stateContent)
        .filter(key => !accountsToRemove.includes(stateContent[key].author))
        .reduce(
            (acc, cur) => ({
                ...acc,
                [cur]: stateContent[cur],
            }),
            {}
        );

export default function stateCleaner(state) {
    return {
        ...state,
        accounts: filterAccounts(state.accounts),
        content: filterContent(state.content),
    };
}

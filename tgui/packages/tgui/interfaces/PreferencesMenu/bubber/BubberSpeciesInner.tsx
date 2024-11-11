// This is it's own file because of the sheer amount of GIGAFUCK edits that exist.
// It's not worth it, just make a new file, man. - Rimi

import { classes } from 'common/react';
import { useBackend } from '../../../backend';
import {
  BlockQuote,
  Box,
  Button,
  Section,
  Stack,
  Tooltip,
} from '../../../components';
import {
  PreferencesMenuData,
  ServerData,
  Species,
  createSetPreference,
} from '../data';
import { useState } from 'react';
import { Diet, SpeciesPerks } from '../SpeciesPage';

export const BubberSpeciesPageInner = (props: {
  handleClose: () => void;
  species: ServerData['species'];
}) => {
  const { act, data } = useBackend<PreferencesMenuData>();
  const setSpecies = createSetPreference(act, 'species');

  let species: [string, Species][] = Object.entries(props.species).map(
    ([species, data]) => {
      return [species, data];
    },
  );

  // Humans are always the top of the list
  const humanIndex = species.findIndex(([species]) => species === 'human');
  const swapWith = species[0];
  species[0] = species[humanIndex];
  species[humanIndex] = swapWith;

  const [previewedSpecies, setPreviewedSpecies] = useState(
    data.character_preferences.misc.species,
  );

  const currentSpecies = species.filter(([speciesKey]) => {
    return speciesKey === previewedSpecies;
  })[0][1];

  return (
    <Stack vertical fill>
      <Stack.Item align="center" fontSize="1.2em">
        <Button
          icon="check"
          onClick={() => setSpecies(previewedSpecies)}
          children="Apply Species"
          style={{ padding: '5px' }}
        />
      </Stack.Item>
      <Stack.Item grow>
        <Stack fill>
          <Stack.Item>
            <Box height="calc(100vh - 170px)" overflowY="auto" pr={3}>
              {species.map(([speciesKey, species]) => {
                let speciesPage = (
                  <Button
                    key={speciesKey}
                    onClick={() => {
                      if (species.veteran_only && !data.is_veteran) {
                        return;
                      }
                      setPreviewedSpecies(speciesKey);
                    }}
                    selected={previewedSpecies === speciesKey}
                    tooltip={species.name}
                    style={{
                      display: 'block',
                      height: '64px',
                      width: '64px',
                    }}
                  >
                    <Box
                      className={classes(['species64x64', species.icon])}
                      ml={-1}
                    />
                  </Button>
                );
                if (species.veteran_only && !data.is_veteran) {
                  let tooltipContent =
                    species.name +
                    ' - You need to be a veteran to select this race, apply today!';
                  speciesPage = (
                    <Tooltip content={tooltipContent}>{speciesPage}</Tooltip>
                  );
                }
                return speciesPage;
              })}
            </Box>
          </Stack.Item>

          <Stack.Item grow>
            <Box>
              <Box>
                <Stack fill>
                  <Stack.Item width="100%">
                    <Section
                      title={currentSpecies.name}
                      buttons={
                        // NOHUNGER species have no diet (diet = null),
                        // so we have nothing to show
                        currentSpecies.diet && (
                          <Diet diet={currentSpecies.diet} />
                        )
                      }
                    >
                      <Section title="Description">
                        {currentSpecies.desc.map((text, index) => (
                          <Box key={index} maxWidth="100%">
                            {text}
                            {index !== currentSpecies.desc.length - 1 && (
                              <>
                                <br />
                                <br />
                              </>
                            )}
                          </Box>
                        ))}
                      </Section>

                      <Section title="Features">
                        <SpeciesPerks perks={currentSpecies.perks} />
                      </Section>
                    </Section>
                  </Stack.Item>
                </Stack>
              </Box>

              <Box mt={1}>
                <Section title="Lore">
                  <BlockQuote>{currentSpecies.desc}</BlockQuote>
                </Section>
              </Box>
            </Box>
          </Stack.Item>
        </Stack>
      </Stack.Item>
    </Stack>
  );
};

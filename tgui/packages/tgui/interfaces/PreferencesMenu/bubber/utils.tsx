import { useState } from 'react';
import { useBackend } from '../../../backend';
import { Box, Button, Dropdown, Section, Stack } from '../../../components';
import { CharacterPreview } from '../../CharacterPreview';
import { CharacterControls } from './IndexPage';
import { PreferencesMenuData, createSetPreference } from '../data';
import { NameInput } from '../names';

export const LoadoutPreviewSection = (props: {
  tutorialStatus;
  setMultiNameInputOpen;
}) => {
  const { act, data } = useBackend<PreferencesMenuData>();
  const { character_preview_view } = data;
  const { tutorialStatus, setMultiNameInputOpen } = props;
  return (
    <Section height="100%" title="Preview">
      <Stack vertical>
        <Stack.Item height="250px" align="center">
          {!tutorialStatus && (
            <CharacterPreview height="100%" id={character_preview_view} />
          )}
        </Stack.Item>
        <Stack.Divider />

        <Stack.Item>
          <NameInput
            name={data.character_preferences.names[data.name_to_use]}
            handleUpdateName={createSetPreference(act, data.name_to_use)}
            openMultiNameInput={() => {
              setMultiNameInputOpen(true);
            }}
          />
        </Stack.Item>

        <Stack.Item style={{ textAlign: 'center' }}>
          <Dropdown
            width="100%"
            selected={data.preview_selection}
            options={data.preview_options}
            onSelected={(value) =>
              act('update_preview', {
                updated_preview: value,
              })
            }
          />
        </Stack.Item>
        <Stack.Item align="center">
          <CharacterControls
            handleRotate={(dir) => {
              act('rotate', { dir: dir });
            }}
          />
        </Stack.Item>
      </Stack>
    </Section>
  );
};

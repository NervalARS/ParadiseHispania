/**
 * @file
 * @copyright 2020 Aleksej Komarov
 * @license MIT
 */

import { toFixed } from 'common/math';
import { useLocalState } from 'tgui/backend';
import { useDispatch, useSelector } from 'common/redux';
import {
  Box,
  Button,
  ColorBox,
  Divider,
  Dropdown,
  Input,
  LabeledList,
  NumberInput,
  Section,
  Stack,
  Tabs,
  TextArea,
} from 'tgui/components';
import { ChatPageSettings } from '../chat';
import { clearChat, rebuildChat, saveChatToDisk } from '../chat/actions';
import { THEMES } from '../themes';
import {
  changeSettingsTab,
  updateSettings,
  addHighlightSetting,
  removeHighlightSetting,
  updateHighlightSetting,
} from './actions';
import { SETTINGS_TABS, FONTS, MAX_HIGHLIGHT_SETTINGS } from './constants';
import {
  selectActiveTab,
  selectSettings,
  selectHighlightSettings,
  selectHighlightSettingById,
} from './selectors';
import { chatRenderer } from '../chat/renderer';

export const SettingsPanel = (props, context) => {
  const activeTab = useSelector(context, selectActiveTab);
  const dispatch = useDispatch(context);
  return (
    <Stack fill>
      <Stack.Item>
        <Section fitted fill minHeight="8em">
          <Tabs vertical>
            {SETTINGS_TABS.map((tab) => (
              <Tabs.Tab
                key={tab.id}
                selected={tab.id === activeTab}
                onClick={() =>
                  dispatch(
                    changeSettingsTab({
                      tabId: tab.id,
                    })
                  )
                }
              >
                {tab.name}
              </Tabs.Tab>
            ))}
          </Tabs>
        </Section>
      </Stack.Item>
      <Stack.Item grow basis={0}>
        {activeTab === 'general' && <SettingsGeneral />}
        {activeTab === 'chatPage' && <ChatPageSettings />}
        {activeTab === 'textHighlight' && <TextHighlightSettings />}
      </Stack.Item>
    </Stack>
  );
};

export const SettingsGeneral = (props, context) => {
  const {
    theme,
    fontFamily,
    fontSize,
    lineHeight,
    messageStackInSeconds,
    maxTotalMessage,
  } = useSelector(context, selectSettings);
  const dispatch = useDispatch(context);
  const [freeFont, setFreeFont] = useLocalState(context, 'freeFont', false);
  return (
    <Section height="150px">
      <LabeledList>
        <LabeledList.Item label="Theme">
          <Dropdown
            selected={theme}
            options={THEMES}
            onSelected={(value) =>
              dispatch(
                updateSettings({
                  theme: value,
                })
              )
            }
          />
        </LabeledList.Item>
        <LabeledList.Item label="Font style">
          <Stack inline align="baseline">
            <Stack.Item>
              {(!freeFont && (
                <Dropdown
                  selected={fontFamily}
                  options={FONTS}
                  onSelected={(value) =>
                    dispatch(
                      updateSettings({
                        fontFamily: value,
                      })
                    )
                  }
                />
              )) || (
                <Input
                  value={fontFamily}
                  onChange={(e, value) =>
                    dispatch(
                      updateSettings({
                        fontFamily: value,
                      })
                    )
                  }
                />
              )}
            </Stack.Item>
            <Stack.Item>
              <Button
                content="Custom font"
                icon={freeFont ? 'lock-open' : 'lock'}
                color={freeFont ? 'good' : 'bad'}
                onClick={() => {
                  setFreeFont(!freeFont);
                }}
              />
            </Stack.Item>
          </Stack>
        </LabeledList.Item>
        <LabeledList.Item label="Font size">
          <NumberInput
            width="4.2em"
            step={1}
            stepPixelSize={10}
            minValue={8}
            maxValue={32}
            value={fontSize}
            unit="px"
            format={(value) => toFixed(value)}
            onChange={(e, value) =>
              dispatch(
                updateSettings({
                  fontSize: value,
                })
              )
            }
          />
          <Box inline fontSize="1em" mx={1} color="label">
            Maximum messages displayed:
          </Box>
          <NumberInput
            width="4.2em"
            step={100}
            stepPixelSize={3}
            minValue={0}
            maxValue={25000}
            value={maxTotalMessage}
            unit="messages"
            format={(value) => toFixed(value)}
            onChange={(e, value) => SetMessageTotal(value, context)}
          />
        </LabeledList.Item>
        <LabeledList.Item label="Line height">
          <NumberInput
            width="4.2em"
            step={0.01}
            stepPixelSize={2}
            minValue={0.8}
            maxValue={5}
            value={lineHeight}
            format={(value) => toFixed(value, 2)}
            onDrag={(e, value) =>
              dispatch(
                updateSettings({
                  lineHeight: value,
                })
              )
            }
          />
          <Box inline fontSize="1em" mx={1} color="label">
            Stacked message expiration:
          </Box>
          <NumberInput
            width="4.2em"
            step={1}
            stepPixelSize={3}
            minValue={0}
            maxValue={600}
            value={messageStackInSeconds}
            unit="seconds"
            format={(value) => toFixed(value)}
            onChange={(e, value) => SetMessageStackingTime(value, context)}
          />
        </LabeledList.Item>
      </LabeledList>
      <Divider />
      <Stack fill>
        <Stack.Item grow mt={0.15}>
          <Button
            content="Save chat log"
            icon="save"
            tooltip="Export current tab history into HTML file"
            onClick={() => dispatch(saveChatToDisk())}
          />
        </Stack.Item>
        <Stack.Item mt={0.15}>
          <Button.Confirm
            icon="trash"
            confirmContent="Are you sure?"
            content="Clear chat"
            tooltip="Erase current tab history"
            onClick={() => dispatch(clearChat())}
          />
        </Stack.Item>
      </Stack>
    </Section>
  );
};

const TextHighlightSettings = (props, context) => {
  const highlightSettings = useSelector(context, selectHighlightSettings);
  const dispatch = useDispatch(context);
  return (
    <Section fill scrollable height="230px">
      <Section>
        <Stack vertical>
          {highlightSettings.map((id, i) => (
            <TextHighlightSetting
              key={i}
              id={id}
              mb={i + 1 === highlightSettings.length ? 0 : '10px'}
            />
          ))}
          {highlightSettings.length < MAX_HIGHLIGHT_SETTINGS && (
            <Stack.Item>
              <Button
                color="transparent"
                icon="plus"
                content="Add Highlight Setting"
                onClick={() => {
                  dispatch(addHighlightSetting());
                }}
              />
            </Stack.Item>
          )}
        </Stack>
      </Section>
      <Divider />
      <Box>
        <Button icon="check" onClick={() => dispatch(rebuildChat())}>
          Apply now
        </Button>
        <Box inline fontSize="0.9em" ml={1} color="label">
          Can freeze the chat for a while.
        </Box>
      </Box>
    </Section>
  );
};

const TextHighlightSetting = (props, context) => {
  const { id, ...rest } = props;
  const highlightSettingById = useSelector(context, selectHighlightSettingById);
  const dispatch = useDispatch(context);
  const {
    highlightColor,
    highlightText,
    highlightWholeMessage,
    matchWord,
    matchCase,
  } = highlightSettingById[id];
  return (
    <Stack.Item {...rest}>
      <Stack mb={1} color="label" align="baseline">
        <Stack.Item grow>
          <Button
            content="Delete"
            color="transparent"
            icon="times"
            onClick={() =>
              dispatch(
                removeHighlightSetting({
                  id: id,
                })
              )
            }
          />
        </Stack.Item>
        <Stack.Item>
          <Button.Checkbox
            checked={highlightWholeMessage}
            content="Whole Message"
            tooltip="If this option is selected, the entire message will be highlighted in yellow."
            onClick={() =>
              dispatch(
                updateHighlightSetting({
                  id: id,
                  highlightWholeMessage: !highlightWholeMessage,
                })
              )
            }
          />
        </Stack.Item>
        <Stack.Item>
          <Button.Checkbox
            content="Exact"
            checked={matchWord}
            tooltipPosition="bottom-start"
            tooltip="If this option is selected, only exact matches (no extra letters before or after) will trigger. Not compatible with punctuation. Overriden if regex is used."
            onClick={() =>
              dispatch(
                updateHighlightSetting({
                  id: id,
                  matchWord: !matchWord,
                })
              )
            }
          />
        </Stack.Item>
        <Stack.Item>
          <Button.Checkbox
            content="Case"
            tooltip="If this option is selected, the highlight will be case-sensitive."
            checked={matchCase}
            onClick={() =>
              dispatch(
                updateHighlightSetting({
                  id: id,
                  matchCase: !matchCase,
                })
              )
            }
          />
        </Stack.Item>
        <Stack.Item shrink={0}>
          <ColorBox mr={1} color={highlightColor} />
          <Input
            width="5em"
            monospace
            placeholder="#ffffff"
            value={highlightColor}
            onInput={(e, value) =>
              dispatch(
                updateHighlightSetting({
                  id: id,
                  highlightColor: value,
                })
              )
            }
          />
        </Stack.Item>
      </Stack>
      <TextArea
        height="3em"
        value={highlightText}
        placeholder="Put terms to highlight here. Separate terms with commas or vertical bars, i.e. (term1 | term2) or (term1, term2). Regex syntax is /[regex]/"
        onChange={(e, value) =>
          dispatch(
            updateHighlightSetting({
              id: id,
              highlightText: value,
            })
          )
        }
      />
    </Stack.Item>
  );
};

const SetMessageStackingTime = (value, context) => {
  const dispatch = useDispatch(context);
  dispatch(updateSettings({ messageStackInSeconds: value }));
  chatRenderer.setMessageDelayStacking(value);
};

const SetMessageTotal = (value, context) => {
  const dispatch = useDispatch(context);
  dispatch(updateSettings({ maxTotalMessage: value }));
  chatRenderer.setMessageDelayStacking(value);
};

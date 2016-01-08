package com.example.android.todolistgh;

import android.app.AlertDialog;
import android.app.DatePickerDialog;
import android.app.Dialog;
import android.app.DialogFragment;
import android.content.DialogInterface;
import android.os.Bundle;
import android.text.InputType;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.RelativeLayout;

import java.text.SimpleDateFormat;
import java.util.Calendar;

/**
 * Created by ed on 30/11/15.
 */
public class AddTaskDialog extends DialogFragment {

    private String dialogTitle;
    boolean modified;

    private String date, rawDate;
    private Boolean priorityBool = false;
    private EditText dateField, descriptionField, categoryField;
    private setAddTaskListener addDialogListener = null;

    //listener that the corresponding button implements
    public interface setAddTaskListener{
        void onDoneClick(DialogFragment dialogFragment);
    }

    public void setAddDialogListener(setAddTaskListener addDialogListener){
        this.addDialogListener = addDialogListener;
    }

    /**
     * onCreateDialog is a generic builder for generating a dialog
     * per row id given, such that tasks can be added to the db
     * @param savedInstanceState the parsed data for the given context
     * @return the appropriate dialog
     */
    @Override
    public Dialog onCreateDialog(Bundle savedInstanceState){
        AlertDialog.Builder builder = new AlertDialog.Builder(getActivity());
        builder.setTitle("Add a task")
                .setPositiveButton("Done", new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int id) {
                        if (addDialogListener != null) {
                            addDialogListener.onDoneClick(AddTaskDialog.this);
                        }
                    }
                })
                .setNegativeButton("Cancel", new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int id) {

                    }
                });

        RelativeLayout propertiesEntry = new RelativeLayout(this.getActivity());
        propertiesEntry.setGravity(Gravity.CENTER);
        RelativeLayout.LayoutParams propertiesEntryParams =
                new RelativeLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT,
                        ViewGroup.LayoutParams.MATCH_PARENT);
        propertiesEntry.setLayoutParams(propertiesEntryParams);

        dateField = new EditText(this.getActivity());
        RelativeLayout.LayoutParams dateParams =
                new RelativeLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT,
                        ViewGroup.LayoutParams.WRAP_CONTENT);
        dateParams.addRule(RelativeLayout.ALIGN_START, RelativeLayout.TRUE);
        dateParams.setMarginStart(10);
        dateParams.setMarginEnd(10);
        dateField.setSingleLine();
        dateField.setHint("Date");
        dateField.setLayoutParams(dateParams);
        dateField.setId(View.generateViewId());

        final Calendar calendar = Calendar.getInstance();
        final DatePickerDialog.OnDateSetListener dateSetListener
                = new DatePickerDialog.OnDateSetListener() {
            @Override
            public void onDateSet(DatePicker view, int year, int monthOfYear, int dayOfMonth) {
                calendar.set(Calendar.DAY_OF_MONTH, dayOfMonth);
                calendar.set(Calendar.MONTH, monthOfYear);
                calendar.set(Calendar.YEAR, year);
                setDate(calendar);
                setRawDate(calendar);
            }
        };

        dateField.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                new DatePickerDialog(getActivity(), dateSetListener,
                        calendar.get(Calendar.YEAR),
                        calendar.get(Calendar.MONTH),
                        calendar.get(Calendar.DAY_OF_MONTH))
                        .show();
            }
        });

        categoryField = new EditText(this.getActivity());
        RelativeLayout.LayoutParams categoryParams =
                new RelativeLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT,
                        ViewGroup.LayoutParams.WRAP_CONTENT);
        categoryParams.addRule(RelativeLayout.BELOW, dateField.getId());
        categoryParams.setMarginStart(10);
        categoryParams.setMarginEnd(10);
        categoryField.setSingleLine();
        categoryField.setInputType(InputType.TYPE_CLASS_TEXT);
        categoryField.setHint("Category");
        categoryField.setLayoutParams(categoryParams);
        categoryField.setId(View.generateViewId());

        descriptionField = new EditText(this.getActivity());
        RelativeLayout.LayoutParams descriptionParams =
                new RelativeLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT,
                        ViewGroup.LayoutParams.WRAP_CONTENT);
        descriptionParams.addRule(RelativeLayout.BELOW, categoryField.getId());
        descriptionParams.setMarginStart(10);
        descriptionParams.setMarginEnd(10);
        descriptionField.setSingleLine();
        descriptionField.setInputType(InputType.TYPE_CLASS_TEXT);
        descriptionField.setHint("Description");
        descriptionField.setLayoutParams(descriptionParams);
        descriptionField.setId(View.generateViewId());

        /*
        final RadioButton[] priority = new RadioButton[1];
        priorityGroup = new RadioGroup (this.getActivity());
        priorityGroup.setOrientation(RadioGroup.HORIZONTAL);
        priority[0] = new RadioButton(this.getActivity());
        priorityGroup.addView(priority[0]);
        priority[0].setText("Important");
        RelativeLayout.LayoutParams priorityParams =
                new RelativeLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT,
                        ViewGroup.LayoutParams.WRAP_CONTENT);
        priorityParams.addRule(RelativeLayout.BELOW, descriptionField.getId());
        priorityParams.setMarginStart(10);
        priorityParams.setMarginEnd(10);
        priorityGroup.setLayoutParams(priorityParams);
        priorityGroup.setId(View.generateViewId());

        priorityGroup.setOnCheckedChangeListener(new RadioGroup.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(RadioGroup group, int checkedId) {
                if(priority[0].isChecked()){
                    setPriority(true);
                } else {
                    setPriority(false);
                }
            }
        });
        */

        //priorityField = new View(this.getActivity());
        final CheckBox priorityBox = new CheckBox(this.getActivity());
        priorityBox.setText("Important");
        RelativeLayout.LayoutParams priorityParams =
                new RelativeLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT,
                        ViewGroup.LayoutParams.WRAP_CONTENT);
        priorityParams.addRule(RelativeLayout.BELOW, descriptionField.getId());
        priorityParams.setMarginStart(10);
        priorityParams.setMarginEnd(10);
        //priorityField.addView(priorityBox);
        priorityBox.setLayoutParams(priorityParams);
        priorityBox.setId(View.generateViewId());

        priorityBox.setOnCheckedChangeListener(new CheckBox.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                if(priorityBox.isChecked()){
                    setPriority(true);
                } else {
                    setPriority(false);
                }
            }

        });

        propertiesEntry.addView(dateField);
        propertiesEntry.addView(categoryField);
        propertiesEntry.addView(descriptionField);
        propertiesEntry.addView(priorityBox);

        builder.setView(propertiesEntry);

        return builder.create();
    }

    public String getDate(){return date;}
    public String getDateField(){return dateField.getText().toString();}
    public String getDescription(){return descriptionField.getText().toString();}
    public String getCategory(){return categoryField.getText().toString();}
    public String getRawDate(){return rawDate;}

    public void setPriority(boolean priority){this.priorityBool=priority;}
    public Boolean getPriority() {return priorityBool;}

    /**
     * Takes the chosen time and renders it in the given format for the user to see
     * @param calender the appropriate chosen time for the task
     */
    private void setDate(Calendar calender){
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("dd/MM/yyyy");
        dateField.setText(simpleDateFormat.format(calender.getTime()));
        this.date = dateField.getText().toString();
    }

    /**
     * Takes the chosen time for rendering in a hidden field in the db for sorting later
     * @param calender the appropriate chosen time for the task
     */
    private void setRawDate(Calendar calender){
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        this.rawDate = simpleDateFormat.format(calender.getTime());
    }

}


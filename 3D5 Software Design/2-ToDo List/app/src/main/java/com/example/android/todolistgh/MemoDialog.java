package com.example.android.todolistgh;

import android.app.AlertDialog;
import android.app.Dialog;
import android.app.DialogFragment;
import android.content.DialogInterface;
import android.os.Bundle;
import android.text.InputType;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.RelativeLayout;

/**
 * Created by sidgupta on 09/12/2015.
 */
public class MemoDialog extends DialogFragment{

    private String dialogTitle;
    boolean modified;

    private EditText memoField;
    private Button emailButton;
    private setMemoListener memoDialogListener = null;
    private Connectivity connectivity;

    //listener that the corresponding button implements
    public interface setMemoListener{
        void onDoneClick(DialogFragment dialogFragment);
    }

    public void setAddDialogListener(setMemoListener addDialogListener){
        this.memoDialogListener = memoDialogListener;
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
        builder.setTitle("Add a Note")
                .setPositiveButton("Done", new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int id) {
                        if (memoDialogListener != null) {
                            memoDialogListener.onDoneClick(MemoDialog.this);
                        }
                    }
                })
                .setNegativeButton("Cancel", new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int id) {

                    }
                })
                .setNeutralButton("Email", new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int id) {
                        connectivity.sendToEmail(memoField.getText().toString());
                    }
                });

        connectivity = new Connectivity(this.getActivity());

        RelativeLayout propertiesEntry = new RelativeLayout(this.getActivity());
        propertiesEntry.setGravity(Gravity.CENTER);
        RelativeLayout.LayoutParams propertiesEntryParams =
                new RelativeLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT,
                        ViewGroup.LayoutParams.MATCH_PARENT);
        propertiesEntry.setLayoutParams(propertiesEntryParams);

        memoField = new EditText(this.getActivity());
        RelativeLayout.LayoutParams categoryParams =
                new RelativeLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT,
                        ViewGroup.LayoutParams.WRAP_CONTENT);
        categoryParams.setMarginStart(10);
        categoryParams.setMarginEnd(10);
        memoField.setSingleLine();
        memoField.setInputType(InputType.TYPE_CLASS_TEXT);
        memoField.setHint("Enter note");
        memoField.setLayoutParams(categoryParams);
        memoField.setId(View.generateViewId());

        propertiesEntry.addView(memoField);

        builder.setView(propertiesEntry);

        return builder.create();
    }

    public String getMemo(){return memoField.getText().toString();}
}
